#!/bin/bash

source log_functions.sh

# Check if yq is installed; install it if not
if ! command -v yq &> /dev/null; then
    echo "yq is not installed. Installing yq..." "$0"
    sudo wget https://github.com/mikefarah/yq/releases/download/v4.35.2/yq_linux_amd64 -O /usr/local/bin/yq
    sudo chmod +x /usr/local/bin/yq
    log "yq installed successfully." "$0"
else
    log "yq is already installed." "$0"
fi