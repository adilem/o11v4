# o11v4 - Cracked by @dandi_boy with help from drmhelp

## SUPPORT FUTURE WORKS

BITCOIN : 
```sh
bc1qhp8gzr4a2w2hatwhrf7m4t7a7yxa680ge0thn8
```

ETHEREUM : 
```sh
0x1dBbF9F198240825BE119126AbA1b8D5082b7196
```

Tested on **Ubuntu 20-23**

## Prerequisites

### 1. Create the Required Directory
Run the following command to create the necessary directory:
```sh
sudo mkdir -p /root/o11/ && cd /root/o11/
```
### 2. Install Nodejs/NPM

Run the following command to install the necessary software if you want to use nodejs:
```sh
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt install -y nodejs && npm install -g pm2 && npm install express
```

```sh
sudo mkdir -p /root/o11/ && cd /root/o11/ && curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt install -y nodejs && npm install -g pm2 && npm install express && git clone https://github.com/adilem/o11v4 && cd /root/o11/o11v4 && pm2 start server.js --name licserver --silent && pm2 startup && pm2 save && chmod +x o11v4 && ./o11v4 -p 8484
```

```sh
sudo curl -fsSL https://github.com/adilem/o11v4/raw/main/install.sh -o /root/install.sh && sudo chmod +x /root/install.sh && sudo bash /root/install.sh

```
## Setting Up & Starting the License Server Proxy

open the server file and add in your servers ip address to the ipAddress veriable then save

Run the following commands to set up and start the license server:
```sh
## if using nodejs
pm2 start server.js --name licserver --silent

## if using python
pm2 start server.py --name licserver --interpreter python3

then

pm2 startup
pm2 save

nohup ./run.sh > /dev/null 2>&1 &
```
