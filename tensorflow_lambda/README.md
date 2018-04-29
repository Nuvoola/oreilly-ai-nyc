# TensorFlow + AWS Lambda

## Create Smaller TensorFlow Package

1. Launch and log into you Jupyter Notebook or native Linux terminal.
2. Set up virtual environment:

```bash
    virtualenv venv
    source venv/bin/activate
```

3. Install TensorFlow:

```bash
    pip install tensorflow
```

4. Clone repo:

```bash
    git clone https://github.com/3Blades/oreilly-ai-nyc
```

5. Create regression model:

```bash
    cd oreilly-ai-nyc/tensorflow_lambda
    python run_model.py
```

6. Create `tensorflow` directory and initialization file:

```bash
    bash config/setup.sh
```

7. Create zip file with dependencies and move zip file to parent directory:

```bash
    cd tensorflow
    zip -r9 tensorflow.zip .
    mv tensorflow.zip ../
```

8. Add remaining files to `tensorflow.zip`:

```bash
    cd ..
    zip -ru tensorflow.zip \
    handler.py \
    tf_regression.py \
    run_model.py \
    settings.ini \
    model
```

## Configure Lambda

### Using AWS CLI

1. Set up AWS credentials:

```bash
    pip install awscli --upgrade
    aws configure
```

2. Add your Key ID, your Secret, your region name, and your default output format.

For example:

```bash
    (venv) root@4e77bc704921:/resources/ideas/pocs/tensorflow_lambda# aws configure
    AWS Access Key ID [None]: AKIAJXLLDSJ2UABC123
    AWS Secret Access Key [None]: ABC123euYrqXeoC4fvGNEjCYg64AxBRL1ABC123
    Default region name [None]: us-west-2
    Default output format [None]: json
```

3. Upload to Lambda

```bash
    aws lambda create-function \
    --function-name tensorflow-lambda \
    --zip-file fileb://tensorflow.zip \
    --runtime python2.7 \
    --region us-east-1 \
    --role MY_ROLE_ARN \
    --handler handler.predict \
    --memory-size 1536 \
    --timeout 60
```

> Substitute `MY_ROLE_ARN` with your `IAM Role`.

### (Optional) Using Serverless

1. Install serverless:

```bash
    chown -R $USER:$(id -gn $USER) /root/.config
    npm install -g serverless
```

2. Build and deploy with serverless:

```bash
    serverless deploy
```

## Local testing

Install python local lambda testing tool:

```bash
    pip install python-lambda-local
```

Run local test:

```bash
    python-lambda-local -f predict -t 5 handler.py event.json
```

To change input value edit `event.json` file.
