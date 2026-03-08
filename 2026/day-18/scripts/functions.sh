#!/bin/bash

greet() {
        echo "Hello, $1"
        }
greet $1

add() {
      sum=$(( $1 + $2))
      echo "$sum"
      }

read -p "ENTER THE NUMBER A: " A
read -p "ENTER THE NUMBER B: " B

add A B 
