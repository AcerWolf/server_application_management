#!/bin/bash

log "Running stop_apps..." "$0"
chmod +x stop_apps.sh
./stop_apps.sh
log "stop_apps finished." "$0"

log "Running update_apps..." "$0"
chmod +x update_apps.sh
./update_apps.sh
log "update_apps finished." "$0"

log "Running setup_cron..." "$0"
chmod +x setup_cron.sh
./setup_cron.sh
log "setup_cron finished." "$0"
