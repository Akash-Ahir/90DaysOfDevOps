#!/bin/bash
set -euo pipefail

print_system_info() {
    echo "=== HOST NAME AND SYSTEM INFO ==="
    echo "HostName : $(hostname)"
    echo "Kernel   : $(uname -r)"
    echo "OS       : $(grep -E '^(NAME|VERSION)=' /etc/os-release)"
    echo ""
}

# Print uptime
print_uptime() {
    echo "=== UPTIME DURATION ==="
    uptime -p
    echo ""
}
print_disk_usage() {
    echo "=== DISK USAGE ==="
    df -h | awk 'NR==1'
    df -h | sort -hr -k3 | head -5
    echo ""
}
print_memory() {
    echo "=== MEMORY USAGE ==="
    free -h
    echo ""
}
print_top_processes() {
    echo "=== CPU PROCESSES ==="
    ps aux --sort=-%cpu | head -6
    echo ""
}
main() {
    print_system_info
    print_uptime
    print_disk_usage
    print_memory
    print_top_processes
}

main "$@"

ubuntu@AKASH:~$ 
