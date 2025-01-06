pip install airflow-code-editor

pip install black isort fs-s3fs fs-gcsfs

docker compose up flower

# Airflow Docker

## Before you begin

This procedure assumes familiarity with Docker and Docker Compose. If you haven’t worked with these tools before, you should take a moment to run through the Docker Quick Start (especially the section on Docker Compose) so you are familiar with how they work.

Follow these steps to install the necessary tools, if you have not already done so.

Install Docker Community Edition (CE) on your workstation. Depending on your OS, you may need to configure Docker to use at least 4.00 GB of memory for the Airflow containers to run properly. Please refer to the Resources section in the Docker for Windows or Docker for Mac documentation for more information.

Install Docker Compose v2.14.0 or newer on your workstation.

Older versions of docker-compose do not support all the features required by the Airflow docker-compose.yaml file, so double check that your version meets the minimum version requirements.

**Tip**

The default amount of memory available for Docker on macOS is often not enough to get Airflow up and running. If enough memory is not allocated, it might lead to the webserver continuously restarting. You should allocate at least 4GB memory for the Docker Engine (ideally 8GB).

You can check if you have enough memory by running this command:

```
docker run --rm "debian:bookworm-slim" bash -c 'numfmt --to iec $(echo $(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE))))'
```
Warning

Some operating systems (Fedora, ArchLinux, RHEL, Rocky) have recently introduced Kernel changes that result in Airflow in Docker Compose consuming 100% memory when run inside the community Docker implementation maintained by the OS teams.

This is an issue with backwards-incompatible containerd configuration that some of Airflow dependencies have problems with and is tracked in a few issues:

Moby issue

Containerd issue

There is no solution yet from the containerd team, but seems that installing Docker Desktop on Linux solves the problem as stated in This comment and allows to run Breeze with no problems.

Fetching docker-compose.yaml
To deploy Airflow on Docker Compose, you should fetch docker-compose.yaml.

```
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.10.4/docker-compose.yaml'
```
**Important**

From July 2023 Compose V1 stopped receiving updates. We strongly advise upgrading to a newer version of Docker Compose, supplied docker-compose.yaml may not function accurately within Compose V1.

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

Setting the right Airflow user
On Linux, the quick-start needs to know your host user id and needs to have group id set to 0. Otherwise the files created in dags, logs and plugins will be created with root user ownership. You have to make sure to configure them for the docker-compose:

```
mkdir -p ./dags ./logs ./plugins ./config
echo -e "AIRFLOW_UID=$(id -u)" > .env
```

See Docker Compose environment variables

For other operating systems, you may get a warning that AIRFLOW_UID is not set, but you can safely ignore it. You can also manually create an .env file in the same folder as docker-compose.yaml with this content to get rid of the warning:

```
AIRFLOW_UID=50000
```

Initialize the database
On all operating systems, you need to run database migrations and create the first user account. To do this, run.

```
docker compose up airflow-init
```

After initialization is complete, you should see a message like this:

airflow-init_1       | Upgrades done
airflow-init_1       | Admin user airflow created
airflow-init_1       | 2.10.4
start_airflow-init_1 exited with code 0
The account created has the login airflow and the password airflow.

## Cleaning-up the environment

The docker-compose environment we have prepared is a “quick-start” one. It was not designed to be used in production and it has a number of caveats - one of them being that the best way to recover from any problem is to clean it up and restart from scratch.

The best way to do this is to:

Run docker compose down --volumes --remove-orphans command in the directory you downloaded the docker-compose.yaml file

Remove the entire directory where you downloaded the docker-compose.yaml file rm -rf '<DIRECTORY>'

Run through this guide from the very beginning, starting by re-downloading the docker-compose.yaml file

## Running Airflow

Now you can start all services:

docker compose up


