#!/bin/bash


# 1. Disable broken Cassandra repo 
sudo sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/cassandra.repo 2>/dev/null || true

# 2. Update and install required packages

sudo yum update -y
sudo yum install -y git

# 3.  Node.js (LTS)

curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs



#4.  Clone your app from GitHub
# -----------------------------
cd /home/ec2-user
git clone https://github.com/muhammedhamedelgaml/fullStack-node.js-react.git
cd fullStack-node.js-react

# -----------------------------
# 5. Setup & run backend (Node.js app on port 5000)
# -----------------------------

cd backend
sudo npm install
node index.js > backend.log 2>&1 &

