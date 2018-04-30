# TensorFlow + Google Cloud Functions

## TensorFlow.js

1. Launch and log into you Jupyter Notebook or native Linux terminal.
2. Install [NVM](https://github.com/creationix/nvm#installation)
3. Install latest stable version of Node and make that the default version:

```bash
    nvm install stable
    nvm alias default stable
```

4. Install [Yarn](https://yarnpkg.com/lang/en/docs/install/#mac-stable)

6. Create project directory and cd into it:

```bash
    mkdir ~/azure_http
    cd ~/azure_http
```

7. Rename the index file:

```bash
    cp index_helloWorld.js index.js
```

8. Deploy the hello world function. [Log into Azure Portal](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-function-app-portal) to deploy your function.

> If successful, the response will contain the URL for your function's endpoint.

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

3. Update your [Azure function](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-function-app-portal).

## Local testing

1. Install [Azure Functions Emulator](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local#linux) (currently Preview).

2. Validate `func` command:

```bash
    func -help
```

3. [Run locally](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local)
