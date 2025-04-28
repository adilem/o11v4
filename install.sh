#!/bin/bash

# Gerekli dizini oluştur
sudo mkdir -p /home/o11/ && cd /home/o11/

# Node.js, pm2 ve express kurulumları
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - 
sudo apt install -y nodejs 
npm install -g pm2 
npm install express

# Repo'yu klonla
git clone https://github.com/adilem/o11v4

# o11v4 dizinine geç
cd /home/o11/o11v4

# PM2 ile sunucuyu başlat
pm2 start server.js --name licserver --silent

# PM2'yi boot'ta başlatacak şekilde yapılandır
pm2 startup
pm2 save

# o11_v4 dosyasını çalıştırılabilir hale getir
chmod +x o11_v4

# o11_v4'i arka planda çalıştır
nohup ./o11_v4 -p 5555 &> /home/o11/o11v4/o11v4.log &
