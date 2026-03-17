#!/bin/bash
set -euo pipefail

usage(){
    echo "Usage: ./log_analyzer.sh <path of your log>"
    exit 1
}

validate_input() {
    if [ "$#" -eq 0 ]; then
        echo "Error: No log file path provided." >&2
        usage
    fi
    
    LOG_FILE="$1"
    if [ ! -f "$LOG_FILE" ]; then
        echo "Error: File '$LOG_FILE' does not exist." >&2
        exit 1
    fi
}

count_errors() {
    echo "==========TOTAL ERROR COUNT=========="
    ERROR_COUNT=$(grep -Ec "ERROR|Failed" "$LOG_FILE")
    echo "$ERROR_COUNT"
}

show_critical_events() {
    echo -e "\n==========CRITICAL MESSAGES=========="
    grep -n "CRITICAL" "$LOG_FILE"
}

show_top_errors() {
    echo -e "\n==========TOP 5 ERROR MESSAGES=========="
    grep "ERROR" "$LOG_FILE" | \
        awk '{$1=$2=$3=$NF=""; print}' | \
        sort | uniq -c | sort -nr | head -5
}

generate_report() {
    DATE_ANALYSIS=$(date +'%Y-%m-%d')
    REPORT_FILE="log_report_${DATE_ANALYSIS}.txt"
    
    {
        echo "Log Analysis Report"
        echo "==================="
        echo "Date of Analysis: $DATE_ANALYSIS"
        echo "Log File Name: $LOG_FILE"
        echo "Total Lines Processed: $(wc -l < "$LOG_FILE")"
        echo "Total Error Count: $ERROR_COUNT"
        echo ""
        echo "==========TOP 5 ERROR MESSAGES=========="
        grep "ERROR" "$LOG_FILE" | \
            awk '{$1=$2=$3=$NF=""; print}' | \
            sort | uniq -c | sort -nr | head -5
        echo ""
        echo "==========CRITICAL MESSAGES=========="
        grep -n "CRITICAL" "$LOG_FILE"
    } > "$REPORT_FILE"
    
    echo -e "\nReport generated: $REPORT_FILE"
}

main() {
    validate_input "$@"
    echo "Log file found: '$LOG_FILE'. Proceeding with processing."
    
    count_errors
    show_critical_events
    show_top_errors
    generate_report
}

main "$@"
