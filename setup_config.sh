#!/bin/bash

CONFIG_FILE="../my_apps/config.yaml"

# Check if the config file exists
if [ -f "$CONFIG_FILE" ]; then
    echo "Config file '$CONFIG_FILE' already exists."
else
    # Create a sample config.yaml file
    cat <<EOL > "$CONFIG_FILE"
# Example config.yaml

# List of your applications
applications:
  - name: App1
    repository: https://github.com/your_username/app1.git

  - name: App2
    repository: https://github.com/your_username/app2.git

# Add more applications as needed

EOL

    echo "Sample '$CONFIG_FILE' created. Please edit this file to add your projects."
fi
