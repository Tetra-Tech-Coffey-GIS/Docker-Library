# Quickstart
Use this command to run.
```
.\makedirsandenv.bat
docker compose --profile flower up
```

# Airflow Docker

## Before you begin

This procedure assumes familiarity with Docker and Docker Compose. If you haven’t worked with these tools before, you should take a moment to run through the Docker Quick Start (especially the section on Docker Compose) so you are familiar with how they work.

Follow these steps to install the necessary tools, if you have not already done so.

Install Docker Community Edition (CE) on your workstation. Depending on your OS, you may need to configure Docker to use at least 4.00 GB of memory for the Airflow containers to run properly. Please refer to the Resources section in the Docker for Windows or Docker for Mac documentation for more information.

Install Docker Compose v2.14.0 or newer on your workstation.

## Docker-Compose.yml
This file contains several service definitions:

- airflow-scheduler - The scheduler monitors all tasks and DAGs, then triggers the task instances once their dependencies are complete.

- airflow-webserver - The webserver is available at http://localhost:8080.

- airflow-worker - The worker that executes the tasks given by the scheduler.

- airflow-triggerer - The triggerer runs an event loop for deferrable tasks.

- airflow-init - The initialization service.

- postgres - The database.

- redis - The redis - broker that forwards messages from scheduler to worker.

Optionally, you can enable flower by adding --profile flower option, e.g. docker compose --profile flower up, or by explicitly specifying it on the command line e.g. docker compose up flower.

flower - The flower app for monitoring the environment. It is available at http://localhost:5555.

All these services allow you to run Airflow with CeleryExecutor. For more information, see Architecture Overview.

Some directories in the container are mounted, which means that their contents are synchronized between your computer and the container.

- ./dags - you can put your DAG files here.

- ./logs - contains logs from task execution and scheduler.

- ./config - you can add custom log parser or add airflow_local_settings.py to configure cluster policy.

- ./plugins - you can put your custom plugins here.

This file uses the latest Airflow image (apache/airflow). If you need to install a new Python library or system library, you can build your image.

## Initializing Environment

Before starting Airflow for the first time, you need to prepare your environment, i.e. create the necessary files, directories and initialize the database.

run makedirsandenv.bat, or the command:

```
mkdir -p ./dags ./logs ./plugins ./config
echo -e "" > .env
```

See Docker Compose environment variables

## Running Airflow

Now you can start all services:
```
docker compose --profile flower up
```

