#!/bin/bash

source log_functions.sh

CONFIG_FILE="../my_apps/config.yaml"

./install_yq.sh

# Check if the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    log "Config file '$CONFIG_FILE' not found. Please create the config file first." "$0"
    exit 1
fi

# Read the config.yaml file using yq
applications=$(yq eval '.applications' "$CONFIG_FILE")

# Loop through each application in the config.yaml and start Docker Compose
for app in $applications; do
    name=$(echo "$app" | yq eval '.name')
    repository=$(echo "$app" | yq eval '.repository')

    # Check if the Docker Compose file exists in the app directory
    app_dir="../my_apps/$name"
    compose_file="$app_dir/docker-compose.yml"
    
    if [ ! -f "$compose_file" ]; then
        log "Docker Compose file not found for $name in $compose_file. Skipping..." "$0"
    else
        # Change to the app directory and start Docker Compose
        cd "$app_dir"
        docker-compose up -d
        log "Started Docker Compose for $name" "$0"
        cd ..
    fi
done
