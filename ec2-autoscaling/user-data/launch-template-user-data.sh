#!/bin/bash

# Install update and Docker on Linux
sudo yum check-update
sudo yum update -y
sudo yum install -y docker

# Starting and enabling docker
sudo systemctl start docker 
sudo systemctl enable docker 
# sudo service docker start

# Run container nodejs-demoapp
docker run -d -p 3000:3000 ghcr.io/benc-uk/nodejs-demoapp:latest