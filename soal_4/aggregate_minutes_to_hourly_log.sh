#!/bin/bash

# Konfigurasi cron
# 0 * * * * /path/to/aggregate_minutes_to_hourly_log.sh

log_dir="/home/$USER/log"

log_file_agg="$log_dir/metrics_agg_$(date +%Y%m%d%H).log"

min_vals=()
max_vals=()
sum_vals=()
count=0

header="type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size"
echo "$header" > "$log_file_agg"

for log_file in "$log_dir"; do
    count=$((count + 1))

    values=($(<"$log_file"))

    if [ $count -eq 1 ]; then
        min_vals=("${values[@]:1}")
        max_vals=("${values[@]:1}")
    fi

    for i in "${!values[@]}"; do
        if [ "$i" -gt 0 ]; then
            min_vals[$((i - 1))]=`awk -v a="${min_vals[$((i - 1))]}" -v b="${values[$i]}" 'BEGIN{print (a<b?a:b)}'`
            max_vals[$((i - 1))]=`awk -v a="${max_vals[$((i - 1))]}" -v b="${values[$i]}" 'BEGIN{print (a>b?a:b)}'`
            sum_vals[$((i - 1))]=`awk -v a="${sum_vals[$((i - 1))]}" -v b="${values[$i]}" 'BEGIN{print (a+b)}'`
        fi
    done
done

for i in "${!sum_vals[@]}"; do
    sum_vals[$i]=`awk -v a="${sum_vals[$i]}" -v b="$count" 'BEGIN{print (a/b)}'`
done

echo "minimum,${min_vals[*]}" >> "$log_file_agg"
echo "maximum,${max_vals[*]}" >> "$log_file_agg"
echo "average,${sum_vals[*]}" >> "$log_file_agg"

chmod 600 "$log_file_agg"
