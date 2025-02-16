#!/bin/bash

# Create necessary directories
sudo mkdir -p /root/o11/ && cd /root/o11/

# Install Node.js, pm2 and express
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - 
sudo apt install -y nodejs 
npm install -g pm2 
npm install express

# Clone the repository
git clone https://github.com/adilem/o11v4

# Navigate to the o11v4 directory
cd /root/o11/o11v4

# Start the server with pm2
pm2 start server.js --name licserver --silent

# Enable pm2 to start on boot
pm2 startup
pm2 save

# Make o11v4 executable and start it
chmod +x o11v4
nohup ./o11v4 -p 8484 &> /root/o11/o11v4/o11v4.log &
