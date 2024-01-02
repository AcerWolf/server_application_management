#!/bin/bash

source log_functions.sh

CONFIG_FILE="config.yaml"

./install_yq.sh

# Check if the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    log "Config file '$CONFIG_FILE' not found. Please create the config file first." "$0"
    exit 1
fi

# Read the config.yaml file using yq
applications=$(yq eval '.applications' "$CONFIG_FILE")

# Loop through each application in the config.yaml and pull the repositories
for app in $applications; do
    name=$(echo "$app" | yq eval '.name')
    repository=$(echo "$app" | yq eval '.repository')

    # Define the path to the application directory
    app_dir="../my_apps/$name"

    if [ -d "$app_dir" ]; then
        # Change to the application directory
        cd "$app_dir"
        
        # Check for updates (fetch)
        git fetch origin
        
        # Check if the local branch is behind the remote branch
        if [ "$(git rev-parse HEAD)" != "$(git rev-parse "origin/$(git symbolic-ref --short HEAD)")" ]; then
            log "Changes detected in $name. Restarting Docker Compose..." "$0"
            # Pull changes
            git pull origin "$(git symbolic-ref --short HEAD)"
            # Restart Docker Compose (adjust the command as needed)
            docker-compose down
            docker-compose up -d
        fi
        cd ..
    fi
done

