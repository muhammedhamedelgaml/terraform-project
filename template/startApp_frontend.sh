#!/bin/bash

# -----------------------------
# 1. Disable broken Cassandra repo (optional if not present)
# -----------------------------
sudo sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/cassandra.repo 2>/dev/null || true

# -----------------------------
# 2. Update and install required packages
# -----------------------------
sudo yum update -y
sudo yum install -y git

# -----------------------------
# 3. Install NVM & Node.js (LTS)
# -----------------------------
export NVM_DIR="/home/ec2-user/.nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load NVM for current script
source "$NVM_DIR/nvm.sh"

nvm install --lts
nvm use --lts

# Make NVM load in future shell sessions
echo 'export NVM_DIR="$HOME/.nvm"' >> /home/ec2-user/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /home/ec2-user/.bashrc
chown ec2-user:ec2-user /home/ec2-user/.bashrc



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
sudo rm -rf /usr/share/nginx/html/* && sudo cp -r dist/* /usr/share/nginx/html/ && sudo systemctl reload nginx
