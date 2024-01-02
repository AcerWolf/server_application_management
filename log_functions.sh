#!/bin/bash

log_dir="logs"
mkdir -p "$log_dir"

latest_log=$(ls -t "$log_dir" | head -n 1)
log_file="$log_dir/$latest_log"

initialize_logger() {
    local timestamp="$(date +'%Y%m%d%H%M%S')"
    log_file="$log_dir/log_${timestamp}.log"
    touch "$log_file"
    log "initialised log file ${log_file}" "$0"
}

log() {
    local message="$1"
    local script_name="$2"
    local timestamp="$(date +'%Y-%m-%d %H:%M:%S')"
    
    echo "[${timestamp}] [${script_name}] ${message}"
    echo "[${timestamp}] [${script_name}] ${message}" >> "$log_file"
}
