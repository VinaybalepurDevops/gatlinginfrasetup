#!/bin/bash
mkdir /home/ubuntu/gatling
sudo apt-get update
sudo apt-get install unzip
sudo apt install -y openjdk-11-jre-headless
wget https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/3.9.5/gatling-charts-highcharts-bundle-3.9.5-bundle.zip -P /home/ubuntu/gatling
cd /home/ubuntu/gatling
unzip gatling-charts-highcharts-bundle-3.9.5-bundle.zip
sudo rsync -azvv --ignore-existing -e "ssh -o \"StrictHostKeyChecking no\" -i jump-key" /home/ubuntu/gatlinginfra/sysctl.conf  ubuntu@$1:/etc/sysctl.conf 

