#!/bin/bash

source log_functions.sh

CONFIG_FILE="../my_apps/config.yaml"

./install_yq.sh

if [ ! -f "$CONFIG_FILE" ]; then
    log "Config file '$CONFIG_FILE' not found. Please create the config file first."
    exit 1
fi

# Read the config.yaml file using yq
applications=$(yq eval '.applications' "$CONFIG_FILE")

# Check if the 'my_apps' directory exists; create it if it doesn't
if [ ! -d "../my_apps" ]; then
    mkdir ../my_apps
fi

# Loop through each application in the config.yaml and clone the repository
for app in $applications; do
    name=$(echo "$app" | yq eval '.name')
    repository=$(echo "$app" | yq eval '.repository')

    # Create a directory for the application
    app_dir="../my_apps/$name"
    if [ ! -d "$app_dir" ]; then
        mkdir -p "$app_dir"
    fi

    # Clone the repository into the application directory
    git clone "$repository" "$app_dir"

    log "Cloned $name from $repository to $app_dir" "$0"
done
