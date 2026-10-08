#!/usr/bin/env bash
set -e
set -u
set -o pipefail

report_dir="reports"
mkdir -p "$report_dir"

timestamp=$(date '+%Y%m%d-%H%M%S')
report_file="$report_dir/health-$timestamp.txt"

root_disk_used=$(df -h / | awk 'NR == 2 {print $5}')
process_count=$(ps -ef | awk 'NR > 1 {count++} END {print count+0}')
memory_used=$(free -h | awk '/^Mem:/ {print $3}')
http_status=$(curl --silent --show-error --output /dev/null \
  --write-out '%{http_code}' --max-time 10 https://example.com)

{
  printf '=== Server Health Report ===\n'
  printf 'Host: %s\n' "$(hostname)"
  printf 'Generated: %s\n' "$(date '+%F %T')"
  printf 'Root disk used: %s\n' "$root_disk_used"
  printf 'Running processes: %s\n' "$process_count"
  printf 'Example.com HTTP status: %s\n' "$http_status"
  printf 'Saved report: %s\n' "$report_file"
  printf 'Memory used: %s\n' "$memory_used"
} | tee "$report_file"
