#!/bin/sh
sleep 10
chmod 400 /home/ubuntu/gatlinginfra/jump-key
rsync -azvv --ignore-existing -e "ssh -o \"StrictHostKeyChecking no\" -i jump-key" /home/ubuntu/gatlinginfra/jump-key ubuntu@$1:/home/ubuntu
