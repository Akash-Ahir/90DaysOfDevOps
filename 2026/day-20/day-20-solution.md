# Day 20 – Bash Scripting Challenge: Log Analyzer and Report Generator

**Date**: March 17, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-20)

## Task Overview
I built a log analyzer script to automate the process of analyzing system logs and generating systematic reports a common real-world responsibility for system administrators and DevOps engineers.

You are a system administrator responsible for managing a network of servers. Every day, a log file is generated on each server containing important system events and error messages. Your job is to analyze these log files, identify specific events, and generate a summary report.

---

## Challenge Tasks

## Task 1: Input and Validation
Your script should:
### 1. Accept the path to a log file as a command-line argument

 ```
    usage(){
        echo "Usage: ./log_analyzer.sh <path of your log>"
        exit 1
    }
```
### 2. Exit with a clear error message if no argument is provided
### 3. Exit with a clear error message if the file doesn't exist

```
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

```
---

## Task 2: Error Count
### 1. Count the total number of lines containing the keyword `ERROR` or `Failed`
### 2. Print the total error count to the console

```
ERROR_COUNT=$(grep -Ec "ERROR|Failed" "$LOG_FILE")
echo "$ERROR_COUNT"
```

---

## Task 3: Critical Events
### 1. Search for lines containing the keyword `CRITICAL`
### 2. Print those lines along with their line number
```
show_critical_events() {
    grep -n "CRITICAL" "$LOG_FILE"
}

```

Example output:
```
--- Critical Events ---
Line 84: 2025-07-29 10:15:23 CRITICAL Disk space below threshold
Line 217: 2025-07-29 14:32:01 CRITICAL Database connection lost
```

---

## Task 4: Top Error Messages
### 1. Extract all lines containing `ERROR`
### 2. Identify the **top 5 most common** error messages
### 3. Display them with their occurrence count, sorted in descending order
```
show_top_errors() {
    grep "ERROR" "$LOG_FILE" | awk '{$1=$2=$3=$NF=""; print}' | sort | uniq -c | sort -nr | head -5
```
Example output:
```
--- Top 5 Error Messages ---
45 Connection timed out
32 File not found
28 Permission denied
15 Disk I/O error
9  Out of memory
```

---

## Task 5: Summary Report
Generate a summary report to a text file named `log_report_<date>.txt` (e.g., `log_report_2026-02-11.txt`). The report should include:
### 1. Date of analysis
### 2. Log file name
### 3. Total lines processed
### 4. Total error count
### 5. Top 5 error messages with their occurrence count
### 6. List of critical events with line numbers

```
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
        grep "ERROR" "$LOG_FILE" | awk '{$1=$2=$3=$NF=""; print}' | sort | uniq -c | sort -nr | head -5
        echo ""
        echo "==========CRITICAL MESSAGES=========="
        grep -n "CRITICAL" "$LOG_FILE"
    } > "$REPORT_FILE"
    
    echo -e "\nReport generated: $REPORT_FILE"
}
```


---

## Task 6 (Optional): Archive Processed Logs
Add a feature to:
### 1. Create an `archive/` directory if it doesn't exist
### 2. Move the processed log file into `archive/` after analysis
### 3. Print a confirmation message

```
archive_log() {
    mkdir -p archive
    mv "$LOG_FILE" "archive/"
    echo " Log archived: archive/$("$LOG_FILE")"
}

```
### [log_analyzer.sh](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-20/script/log_analyzer.sh)
<img width="815" height="466" alt="output 1" src="https://github.com/user-attachments/assets/6eac382c-8563-4d16-b870-461e3c53f7dd" />

<img width="1091" height="280" alt="Screenshot 2026-03-17 150303" src="https://github.com/user-attachments/assets/2e7839aa-3d2e-4c82-b425-36cdb3edd5f4" />

---

