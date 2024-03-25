#!/bin/bash

# Konfigurasi cron
# * * * * * /home/$USER/minute_log.sh

current_time=$(date +"%Y%m%d%H%M%S")

log_dir="/home/$USER/log"
mkdir -p "$log_dir"

mem_metrics=$(free -m | awk 'NR==2{printf "%s,%s,%s,%s,%s,%s,%s,%s,%s", $2,$3,$4,$5,$6,$7,$3,$6,$4+$9}')

path="/home/$USER/"
path_size=$(du -sh "$path" | awk '{print $1}')

log_line="mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size $mem_metrics,$path,$path_size"

log_file="$log_dir/metrics_$current_time.log"
echo "$log_line" > "$log_file"

chmod 600 "$log_file"
