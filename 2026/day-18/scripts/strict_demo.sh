#!/bin/bash
set -euo pipefall


echo "=== TEST 1: set -e ==="
mkdir docker 
mkdir docker         #<----it will give error becoz file is already created so the script exit (-e)
touch linux
echo "This won't print"


echo "=== TEST 2: set -u ==="
echo $name          #<----$name underdefine variable
echo "This won't print"


echo "=== TEST 3: set -o ===="
ls -l | grep "file"      <----#ls work but grep finds nothing (fails)
echo "This won't print"
