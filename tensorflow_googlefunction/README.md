# TensorFlow + Google Cloud Functions

## TensorFlow.js

1. Launch and log into you Jupyter Notebook or native Linux terminal.
2. Install [NVM](https://github.com/creationix/nvm#installation)
3. Install latest stable version of Node and make that the default version:

```bash
    nvm install stable
    nvm alias default stable
```

4. Install [Google Cloud SDK](https://cloud.google.com/sdk/docs/quickstart-linux)
5. Update and install gcloud components:

```bash
    gcloud components update && \
    gcloud components install beta
```

6. Create project directory and cd into it:

```bash
    mkdir ~/gcf_http
    cd ~/gcf_http
```

7. Rename the index file:

```bash
    cp index_helloWorld.js index.js
```

8. Deploy the hello world function:

```bash
    gcloud beta functions deploy helloGET --trigger-http
```

> If successful, the response will contain the URL for your function's endpoint.

9. Validate response:

```bash
    curl "https://[YOUR_REGION]-[YOUR_PROJECT_ID].cloudfunctions.net/helloGET"
```

> The response in step 8 should contain the `YOUR_REGION` and `YOUR_PROJECT_ID`
values.

## Deploy a Functions with a TensorFlow model

1. Install TensorFlow:

```bash
    npm install @tensorflow/tfjs
```

> Installing TensorFlow locally will update you `package.json` and `package-lock.json`
files. These are needed by Google Cloud Functions to deploy the function with the
right dependencies.

2. Update your index.js file:

```bash
    cp index_tensorFlow.js index.js
```

3. Deploy:

```bash
gcloud beta functions deploy predictGET --trigger-http
```

## Local testing

1. Install [Google Cloud Functions Emulator](https://cloud.google.com/functions/docs/emulator) (currently Alpha):

```bash
npm install -g @google-cloud/functions-emulator
```

2. Validate `functions` command:

```bash
    functions -help
```

3. Start functions service and deploy from current working directory:

```bash
    functions start
    functions deploy helloWorld --trigger-http
```
