#!/bin/bash

file="nodes.txt"

while read -r line; do
    echo -e "$line"
done <$file
