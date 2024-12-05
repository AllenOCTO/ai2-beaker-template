# ATTENTION: You will need to choose the appropriate base image (OS, cuda version, etc)
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

# Set environment variables to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the apt package list and install any necessary packages
# ATTENTION: Customize as needed.
RUN apt-get update && apt-get install -y \
    apt-utils
RUN apt-get update && apt-get install -y \
    software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    python3-dev \
    python3.9 \
    python3.9-dev \
    python3.9-distutils \
    python3.9-venv
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3.9 get-pip.py

# do not remove this, needed for the cluster
RUN apt-get update && apt-get install -y \
    rdma-core infiniband-diags ibutils ibverbs-utils perftest \
    && rm -rf /var/lib/apt/lists/*

# Removes logging issues caused by bufferring. If you have performance critical
# workloads with lots of logging, may want to remove.
ENV PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /usr/src/app

# Setup the image
# ATTENTION: You will need to copy files from the build context.
COPY container-entrypoint.sh .
RUN chmod +x container-entrypoint.sh

CMD ["/usr/src/app/container-entrypoint.sh"]