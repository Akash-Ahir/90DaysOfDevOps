#!/bin/bash

check_disk() {
              df -h | awk 'NR==2{print $3'
}

check_memory() {
                free -h | awk 'NR==2{print $7}'
}

show_details() {
                echon "=====SYSTEM DETAILS====="
                echo "Disk useage of /: "
                check_disk
                echo "Free memory: "
                check_memory
}

show_details
