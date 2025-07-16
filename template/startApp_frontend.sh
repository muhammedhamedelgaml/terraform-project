#!/bin/bash

# 1. Disable broken Cassandra repo (optional if not present)
sudo sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/cassandra.repo 2>/dev/null || true

# -----------------------------
# 2. Update and install required packages

sudo yum update -y
sudo yum install -y git

# install nginx 
sudo amazon-linux-extras enable nginx1
sudo yum clean metadata
sudo  yum install -y nginx
sudo systemctl enable --now nginx



curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc
nvm install --lts
node -e "console.log('Running Node.js ' + process.version)"

#4.  Clone your app from GitHub
# -----------------------------
cd /home/ec2-user
git clone https://github.com/muhammedhamedelgaml/fullStack-node.js-react.git
cd fullStack-node.js-react

# -----------------------------
# 6. Setup & run frontend 
# -----------------------------

cd frontend
npm install
npm run build
sudo mv /tmp/nginx.conf /etc/nginx/nginx.conf
sudo rm -rf /usr/share/nginx/html/* && sudo cp -r dist/* /usr/share/nginx/html/ && sudo systemctl reload nginx
