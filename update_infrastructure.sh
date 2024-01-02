#!/bin/bash

source log_functions.sh

# Navigate to the directory containing the script
cd "$(dirname "$0")"

# Check for updates (fetch)
git fetch origin

# Check if the local branch is behind the remote branch
if [ "$(git rev-parse HEAD)" != "$(git rev-parse "origin/$(git symbolic-ref --short HEAD)")" ]; then
    log "Changes detected in pipeline. Restarting pipeline..." "$0"
    # Pull changes
    git pull origin "$(git symbolic-ref --short HEAD)"
    return 1 # There was an update
else
    return 0
fi