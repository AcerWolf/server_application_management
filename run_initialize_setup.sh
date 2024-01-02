#!/bin/bash

source log_functions.sh
initialize_logger

log "Running install_docker..." "$0"
chmod +x install_docker.sh
./install_docker.sh
log "install_docker finished." "$0"

log "Running install_yq..." "$0"
chmod +x install_yq.sh
./install_yq.sh
log "install_yq finished." "$0"

log "Running setup_config..." "$0"
chmod +x setup_config.sh
./setup_config.sh
log "setup_config finished." "$0"
