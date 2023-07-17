#!/bin/bash


file="nodes.txt"

while read -r line; do
    curl 'http://'$1':8080/computer/'$line'/doDelete/' -X POST --user admin:11eb8a9b6c4c661fc24933123036d5c746
done <$file
