#!/bin/bash

source log_functions.sh
initialize_logger

log "Running update_apps..." "$0"
chmod +x update_apps.sh
./update_apps.sh
log "update_apps finished." "$0"

log "Running setup_cron..." "$0"
chmod +x setup_cron.sh
./setup_cron.sh
log "setup_cron finished." "$0"
