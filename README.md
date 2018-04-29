# Deploy MXNet and TensorFlow deep learning models with AWS Lambda, Google Cloud Functions, and Azure Functions

O'Reilly Media AI Conference NYC - 04/30/2018
---

These are optional requirements in case you would like to follow along with the labs. There are a few options, in the spirit of providing flexibility.

We use [Jupyter Notebooks](https://jupyter.org) to walk through the labs. Jupyter provides a nice web interface which mixes markdown (rich) text, code, and visualizations. It also provides us with the ability to launch terminals (if you prefer that interface) to install additional dependencies, use an interactive console, or run scripts. You can run Jupyter in the cloud or locally. If run locally, we recommend using docker containers.

Downloading or building the docker image is only recommended if you do so before the start of the workshop due to bandwidth. You need to have [docker installed on your local machine](https://docs.docker.com/install/) if you wish to use local docker containers.

## Set Up Environment

## Jupyter in the Cloud

[Jupyter Notebooks](https://jupyter.org) are a great way to mix markdown text, code, and visualizations. Jupyter also provides us with a terminal component which we can use to access cloud resources.

There are several options to run Jupyter in the cloud. Some are listed below. However, we don't have a lot of control over some of these options and therefore would recommend using [IllumiDesk's](https://app.illumidesk.com) environment.

### IllumiDesk

1. Navigate to https://app.illumidesk.com.
2. Authenticate with your GitHub account, or create a new local account with a valid email address.
3. Create a new **public** project. Any project name will do.
4. Create a new Workspace. Select Jupyter Notebok as the workspace type. 1024 or 2048 of RAM should be more than enough.
5. Click on `Start` to start your Jupyter server. Once the server has started, click on the `Lanch` option.
6. You will see your Jupyter Notebook in a new browser tab.

### Other Jupyter Cloud Options

- Azure Notebooks: https://notebooks.azure.com/
- Kaggle Kernels: https://www.kaggle.com/kernels
- Google Colaboratory: https://colab.research.google.com/

## Run Jupyter Locally with Docker

1. [Install Docker](https://app.illumidesk.com) if you haven't done so.

2. Download docker image:

    docker pull illumidesk/notebook:oreilly

3. Run docker container:

    docker run -d -p 8888:8888 illumidesk/notebook:oreilly

4. Open your favorite browser and navigate to http://localhost:8888

## Obtain Lab Files

The lab files are stored in a GitHub repo. Run the commands below in your the terminal of your Jupyter server.

1. Open the terminal
2. Clone git repo:

    git clone https://github.com/3Blades/oreilly-ai-nyc

## Additional Notes

1. Make sure you pull the latest version of the repo from the master branch to ensure you have the latest files.

```bash
    git pull
```

2. We will do our best to provide you with cloud credentials for you to use free of charge, however, there may be some restrictions. Azure, Google, and AWS all offer free tier options for limited use cases.
