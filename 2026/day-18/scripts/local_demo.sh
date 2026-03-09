#!/bin/bash

name="global"     #<------ Global variable

func_a(){
        local var_name="local"     # <--- LOCAL stays inside function only 
        echo "Local variable inside the function : $var_name"
}

func_b(){
        echo "Global/Regular variable inside another function : $name"
}

echo "=== BEFORE FUNCTIONS ==="
echo "Global variable: '$name'"
echo "Local variable: '${var_name:-NOT SET}'"
echo ""

func_a
func_b

echo "=== AFTER FUNCTIONS ==="
echo "Local variable outside the function : '${var_name:-NOT SET}'"
echo "Global/Regular variable outside the function : $name"
