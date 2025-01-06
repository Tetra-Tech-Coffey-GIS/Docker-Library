# Docker ArcGIS Jupyter Lab

Install Docker Desktop.

Copy the following files to your working directory (whereever you want)

- configure_environment.sh
- docker-compose.yml
- requirements.txt

# to run
using command prompt, run
```
docker compose up
```
in the directory you want to work from.

## Configuration

The docker compose is setup to run as a default configuration. To install python packages or configure Jupyter specifically.

Uncomment the line: #      - ./configure_environment.sh:/usr/local/bin/before-notebook.d/configure_environment.sh

Currently the configure_environment script only installsd the packages in requirements.txt.
