#!/bin/bash

source log_functions.sh

# Navigate to the directory containing the script
cd "$(dirname "$0")"

LOCK_FILE="update_pipeline.lock"

# Check if the lock file exists
if [ -e "$LOCK_FILE" ]; then
  # Check if the process with the PID in the lock file is still running
  PID=$(cat "$LOCK_FILE")
  if ps -p $PID > /dev/null; then
    log "Update script is already running (PID: $PID). Exiting." "$0"
    exit 1
  else
    # The process with the PID in the lock file is not running, so remove the stale lock file
    rm "$LOCK_FILE"
  fi
fi

# Create a new lock file with the current script's PID
echo $$ > "$LOCK_FILE"


./update_infrastructure.sh
infrastructure_update=$?

if [ $infrastructure_update -eq 1 ]; then
    log "An infrastructure update is available. Restarting infrastructure..." "$0"
    ./restart_infrastructure &
else
    log "No infrastructure update available. Updating apps..." "$0"
    ./update_apps.sh
fi

# Remove the lock file when the script is done
rm "$LOCK_FILE"