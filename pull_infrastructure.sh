#!/bin/bash

source log_functions.sh

# Get the directory where the script is located
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Navigate to the script directory
cd "$script_dir"

# Pull the latest changes from the Git repository
git pull

# Check if the pull was successful
if [ $? -eq 0 ]; then
    log "Git pull successful." "$0"
else
    log "Git pull failed. Script will not be updated." "$0"
fi
