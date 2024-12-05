#!/bin/sh
set -e

# Log the GPU output. Super helpful for debugging.
nvidia-smi

# Activate the virutal environment.
# ATTENTION: You will need to change depending on python version you are using.
python3.9 -m venv env
. env/bin/activate

# Install the requirements.txt in the running container with retries. 
# ATTENTION: This can optionally be moved into the Dockerfile. However this will
# result in faster image builds.
RETRIES=3
DELAY=5
for attempt in $(seq 1 $RETRIES); do
    set +e  
    pip install -r ./requirements.txt && break
    set -e
    echo "Retrying installs ($attempt/$RETRIES)..."
    sleep $DELAY
done

# This installs the beaker cli. Useful for service-discovery to facilitate distributed training.
for attempt in $(seq 1 $RETRIES); do
    set +e
    git clone https://github.com/allenai/beaker-py.git && break
    set -e
    echo "Retrying beaker-py clone ($attempt/$RETRIES)..."
    sleep $DELAY
done
cd beaker-py
pip install .
cd ..

# Convert your notebook to a Python script
jupyter nbconvert --to python ./src/work.ipynb

# Run the model
python ./model/work.py
