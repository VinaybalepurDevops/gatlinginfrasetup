#!/bin/bash
len="$(terraform output -json ip | jq length)"
a=0
for (( i=0; i<"$len"; i++ ))
do
	ip=$(terraform output -json ip | jq -r .["$i"])
    scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r -i terraform_ec2_key ubuntu@"$ip":/home/ubuntu/gatling/gatling-charts-highcharts-bundle-3.9.5/results/resultfolder/lognode*.zip /home/ubuntu/results
done
