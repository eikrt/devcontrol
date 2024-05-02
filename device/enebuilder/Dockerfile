# Use a base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive

# Update package list and install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        flex \
        libncurses5-dev \
        bc \
        libelf-dev \
        bison \
        vim \
        cpio \
        libssl-dev \
        file \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /enebuilder
COPY . ./
CMD ["/bin/sh"]
