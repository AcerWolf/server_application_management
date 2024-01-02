#!/bin/bash

source log_functions.sh

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    log "Docker is not installed. Installing Docker..." "$0"
    sudo curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh
    log "Docker installed successfully." "$0"
else
    log "Docker is already installed." "$0"
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    log "Docker Compose is not installed. Installing Docker Compose..." "$0"
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    log "Docker Compose installed successfully." "$0"
else
    log "Docker Compose is already installed." "$0"
fi
