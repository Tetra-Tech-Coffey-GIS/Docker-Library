#!/bin/bash
set -eo pipefail
IFS=$'\n\t'
# From: http://redsymbol.net/articles/unofficial-bash-strict-mode/
# Not using `set -u`, as this will not play nice with the image's usage of `JUPYTER_ENV_VARS_TO_UNSET`

# To be run inside the Docker container automatically.
# Ensures that the dependencies are installed when the container spins up

pip install -r ~/work/requirements.txt
export PYTHONPATH=PYTHONPATH:/home/jovyan/work
