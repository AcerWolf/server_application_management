#!/bin/bash

source log_functions.sh

# Define the paths to your scripts
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
update_script_path="${SCRIPT_DIR}/update_pipeline.sh"

# Define the schedules for each script (every ten minutes)
cron_schedule="*/10 * * * *"

# Create a temporary file to hold the cron jobs
temp_cron_file=$(mktemp)

# Write the cron jobs to the temporary file
echo "$cron_schedule $update_script_path" >> "$temp_cron_file"

crontab -r
# Add the cron jobs from the temporary file
crontab "$temp_cron_file"

# Clean up the temporary file
rm "$temp_cron_file"

# Inform the user
log "Cron jobs added:" "$0"
log "$update_script_path will run every ten minutes" "$0"
