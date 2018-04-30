# MXNet package for AWS Lambda

This is a reference application that predicts labels along with their probablities for an image using a pre-trained model with [Apache MXNet](http://mxnet.io) deployed on [AWS Lambda](https://aws.amazon.com/lambda). A Serverless Application Model template (SAM) and instructions are provided to automate the creation of an API endpoint.

You can leverage this package and its precompiled libraries to build your prediction pipeline on AWS Lambda with MXNet.

Additional models can be found in the [Model Zoo](http://data.mxnet.io/models/)

## This repo shows how you can deploy Apache MXNet with AWS Lambda:

- Using AWS CLI to create a Lambda function
- Using Serverless Application Model (SAM) to create a serverless application with API Gateway and AWS Lambda

## Components

- MXNet 0.10.1
- Numpy
- PIL

* boto3 is included in the Lambda environment, if you want to try it locally please pip install boto3 in your virtualenv

## Option 1: Instructions to deploy on AWS Lambda

- Creating a Lambda function from the CLI for the first time by running the following commands:

```
cd mxnet-lambda/src
zip -9r lambda_function.zip  *
aws lambda create-function --function-name mxnet-lambda-v2 --zip-file fileb://lambda_function.zip --runtime python2.7 --region us-east-1 --role {{ REPLACE_WITH_YOUR_ROLE_ARN }} --handler lambda_function.lambda_handler --memory-size 1536 --timeout 60
```
- Updating the Lambda function code

```
aws lambda update-function-code --function-name mxnet-lambda-v2 --zip-file fileb://lambda_function.zip
```
- Basic Test of the Lambda function:
```
aws lambda invoke --invocation-type RequestResponse --function-name mxnet-lambda-v2 --region us-east-1 --log-type Tail --payload '{"url": "https://images-na.ssl-images-amazon.com/images/G/01/img15/pet-products/small-tiles/23695_pets_vertical_store_dogs_small_tile_8._CB312176604_.jpg"}' output_file
```
*{
    "StatusCode": 200,
    "LogResult": "U1RBUlQgUmVxdWVzdElkOiA3NDgwOTNiYy00YmQ5LTExZTgtOTUwNi02YjQ4MjI2MDJiMDQgVmVyc2lvbjogJExBVEVTVApSZXF1ZXN0IE1ldGhvZDogVVJMOiBodHRwczovL2ltYWdlcy1uYS5zc2wtaW1hZ2VzLWFtYXpvbi5jb20vaW1hZ2VzL0cvMDEvaW1nMTUvcGV0LXByb2R1Y3RzL3NtYWxsLXRpbGVzLzIzNjk1X3BldHNfdmVydGljYWxfc3RvcmVfZG9nc19zbWFsbF90aWxlXzguX0NCMzEyMTc2NjA0Xy5qcGcKZG93bmxvYWRpbmcgdGhlIGltYWdlCigxLCAzLCAyMjQsIDIyNCkKTE9DOiBbTG9jYXRpb24oKDQyLjYzNjUyODcsIC04Ljg1MTM5LCAwLjApKSwgTG9jYXRpb24oKDQyLjY1OTEyOTEsIC04Ljg5Njk0MjcsIDAuMCkpLCBMb2NhdGlvbigoNDIuNjkyNjczOSwgLTguOTAyNDYwMywgMC4wKSksIExvY2F0aW9uKCg0Mi42OTI2NzM5LCAtOC45MDI0NjAzLCAwLjApKSwgTG9jYXRpb24oKDQzLjM2MjMzNjQsIC04LjQxMTU5NCwgMC4wKSksIExvY2F0aW9uKCg0Mi41NzUwNTU0LCAtOC4xMzM4NTU4LCAwLjApKSwgTG9jYXRpb24oKDQwLjQ2MzY2NywgLTMuNzQ5MjIsIDAuMCkpXQpFTkQgUmVxdWVzdElkOiA3NDgwOTNiYy00YmQ5LTExZTgtOTUwNi02YjQ4MjI2MDJiMDQKUkVQT1JUIFJlcXVlc3RJZDogNzQ4MDkzYmMtNGJkOS0xMWU4LTk1MDYtNmI0ODIyNjAyYjA0CUR1cmF0aW9uOiAxOTMxLjIxIG1zCUJpbGxlZCBEdXJhdGlvbjogMjAwMCBtcyAJTWVtb3J5IFNpemU6IDE1MzYgTUIJTWF4IE1lbW9yeSBVc2VkOiAxMjcyIE1CCQo=",
    "ExecutedVersion": "$LATEST"
}*

## Option 2 *(Extra Credit)*: Creating an API endpoint with Serverles Application Model (SAM)

* In the AWS Region you plan to deploy, make sure you have an existing Amazon S3 bucket in which SAM can create the deployment artifacts.

Else create a new bucket using the following AWS CLI command:

```
aws s3 mb s3://mxnet-lambda-test --region us-east-1
```

Before deploying the project to SAM for the first time, you'll need to update some variables in  `lambda_function.py` and `template.yaml`/`swagger.yaml` (found in `sam/` folder).

```
# swagger.yaml
# <<region>> : AWS region set in Pre-Requisites, referenced twice in swagger.yaml
# <<accountId>> : your global AWS account ID (found in MyAccount)
# Line 23 and 68
# 23
uri: arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:{{ Replace with Account id }}:function:${stageVariables.LambdaFunctionName}/invocations
# 68
uri: arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:{{ Replace with account id}}:function:${stageVariables.LambdaFunctionName}/invocations


```
- Execute the AWS Cloudformation SAM commands to create the Serverless application

```
aws cloudformation package \
--template-file template.yaml \
--output-template-file template-out.yaml \
--s3-bucket mxnet-lambda-test \
--region us-east-1

aws cloudformation deploy \
--template-file ./template-out.yaml \
--stack-name <STACK_NAME> \
--capabilities CAPABILITY_IAM \
--region us-east-1
```


- Get the URL of the Serverless application that was created

```
$ aws cloudformation describe-stacks --stack-name mxnet-lambda-v2 | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["Stacks"][0]["Outputs"][0]["OutputValue"];' --region us-east-1

Alternately you can go to the AWS cloudformation console, click on your stack to see the output values
```

- Test with GET request

```
curl https://MY_URL/predict?url=https://images-na.ssl-images-amazon.com/images/G/01/img15/pet-products/small-tiles/23695_pets_vertical_store_dogs_small_tile_8._CB312176604_.jpg
```

- Test with POST request

```
curl -H "Content-Type: application/json" -X POST https://MY_URL/predict -d '{"url": "https://images-na.ssl-images-amazon.com/images/G/01/img15/pet-products/small-tiles/23695_pets_vertical_store_dogs_small_tile_8._CB312176604_.jpg"}'
```

## [Advanced] Build MXNet package from source for AWS Lambda
### In case you wondered how the package was created

- compile MXNet on Amazon Linux (AMI name: amzn-ami-hvm-2016.03.3.x86_64-gp2)

```
$ git clone --recursive https://github.com/dmlc/mxnet mxnet
$ cd mxnet
$ make -j $(nproc) USE_OPENCV=0 USE_CUDNN=0 USE_CUDA=0 USE_BLAS=openblas
```

- build python bindings

```
$ cd python
$ python setup.py install
```

- copy python bindings

```
$ mkdir mxnet-lambda-pkg
$ cd mxnet-lambda-pkg
$ cp -r /usr/local/lib/python2.7/site-packages/mxnet-0.10.1-py2.7.egg .
$ mv mxnet-0.10.1-py2.7.egg/mxnet .
```

- copy all the support libraries to lib folder

```
$ mkdir lib

Copy all the following libraries from /usr/local/lib or /usr/lib/ to lib/ directory  

libatlas.a       libcblas.so.3.0    libf77blas.so.3.0  libopenblas.so.0   libptf77blas.so.3
libatlas.so.3    libclapack.so.3    libgfortran.so.3   libptcblas.a       libptf77blas.so.3.0
libatlas.so.3.0  libclapack.so.3.0  liblapack.a        libptcblas.so.3    libquadmath.so.0
libcblas.a       libf77blas.a       liblapack.so.3     libptcblas.so.3.0
libcblas.so.3    libf77blas.so.3    liblapack.so.3.0   libptf77blas.a

```


## Notes

All the necessary libraries needed for MXNet have been copied to the src/lib folder. In addition, PIL for Python is also available for your use. OpenCV was available in the previous release, but has been taken out to reduce the size of the code package. Refer to opencv branch for the code
