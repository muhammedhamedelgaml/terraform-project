#!/bin/bash

# Update & install required packages
sudo yum update -y
sudo yum install -y git curl

# Install NVM and Node.js (LTS)
export NVM_DIR="/home/ec2-user/.nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load NVM
source "$NVM_DIR/nvm.sh"

# Install and use latest LTS Node.js
nvm install --lts
nvm use --lts

# Make NVM available in future sessions
echo 'export NVM_DIR="$HOME/.nvm"' >> /home/ec2-user/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /home/ec2-user/.bashrc
chown ec2-user:ec2-user /home/ec2-user/.bashrc

# Switch to ec2-user home
cd /home/ec2-user

# Clone the app
git clone https://github.com/muhammedhamedelgaml/fullStack-node.js-react.git
cd fullStack-node.js-react

# Backend setup
cd backend
npm install

# Start backend in background on port 5000
nohup node index.js > backend.log 2>&1 &

# Frontend setup
cd ../frontend
npm install

# Start frontend (Vite) in background on port 5173, accessible by ALB/Proxy
nohup npm run dev -- --host > frontend.log 2>&1 &
