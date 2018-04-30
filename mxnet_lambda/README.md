# MXNet + AWS Lambda

This repo's contents are mostly from [here](https://github.com/awslabs/mxnet-lambda).

* boto3 is included in the Lambda environment, if you want to try it locally please pip install boto3 in your virtualenv

## Deploy to AWS Lambda

1. Creating a Lambda function from the CLI for the first time by running the following commands:

```bash
    cd mxnet-lambda/src
    zip -9r lambda_function.zip  *
    aws lambda create-function --function-name mxnet-lambda-v2 --zip-file fileb://lambda_function.zip --runtime python2.7 --region us-east-1 --role {{ REPLACE_WITH_YOUR_ROLE_ARN }} --handler lambda_function.lambda_handler --memory-size 1536 --timeout 60
```

2. Updating the Lambda function code

```bash
    aws lambda update-function-code --function-name mxnet-lambda-v2 --zip-file fileb://lambda_function.zip
```

3. Test of the Lambda function:

```bash
    aws lambda invoke --invocation-type RequestResponse --function-name mxnet-lambda-v2 --region us-east-1 --log-type Tail --payload '{"url": "https://images-na.ssl-images-amazon.com/images/G/01/img15/pet-products/small-tiles/23695_pets_vertical_store_dogs_small_tile_8._CB312176604_.jpg"}' output_file
```

## [Advanced] Create Your Own Package

1. Compile MXNet on Amazon Linux (AMI name: amzn-ami-hvm-2016.03.3.x86_64-gp2)

```bash
    git clone --recursive https://github.com/dmlc/mxnet mxnet
    cd mxnet
    make -j $(nproc) USE_OPENCV=0 USE_CUDNN=0 USE_CUDA=0 USE_BLAS=openblas
```

2. Build python bindings

```bash
    cd python
    python setup.py install
```

3. Copy python bindings

```bash
    mkdir mxnet-lambda-pkg
    cd mxnet-lambda-pkg
    cp -r /usr/local/lib/python2.7/site-packages/mxnet-0.10.1-py2.7.egg .
    mv mxnet-0.10.1-py2.7.egg/mxnet .
```

4. copy all the support libraries to lib folder

```bash
    mkdir lib
```

5. Copy all the following libraries from /usr/local/lib or /usr/lib/ to lib/ directory  

```
libatlas.a       libcblas.so.3.0    libf77blas.so.3.0  libopenblas.so.0   libptf77blas.so.3
libatlas.so.3    libclapack.so.3    libgfortran.so.3   libptcblas.a       libptf77blas.so.3.0
libatlas.so.3.0  libclapack.so.3.0  liblapack.a        libptcblas.so.3    libquadmath.so.0
libcblas.a       libf77blas.a       liblapack.so.3     libptcblas.so.3.0
libcblas.so.3    libf77blas.so.3    liblapack.so.3.0   libptf77blas.a

```
