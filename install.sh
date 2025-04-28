#!/bin/bash

# Gerekli dizini oluştur
sudo mkdir -p /home/o11/ && cd /home/o11/

# Node.js, pm2 ve express kurulumları
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - 
sudo apt install -y nodejs 
sudo npm install -g pm2 
npm install express

# Repo'yu klonla
git clone https://github.com/adilem/o11v4

# o11v4 dizinine geç
cd /home/o11/o11v4

# PM2 ile sunucuyu başlat (Node.js uygulaması)
pm2 start server.js --name licserver --silent

# PM2'yi boot'ta başlatacak şekilde yapılandır
pm2 startup
pm2 save

# o11_v4 dosyasını çalıştırılabilir hale getir
chmod +x o11_v4

# o11_v4'i arka planda çalıştır (isteğe bağlı)
# Bu adımı `pm2` ile zaten başlattık, ayrıca `nohup` kullanmak gereksiz olabilir.
# nohup ./o11_v4 -p 5555 &> /home/o11/o11v4/o11v4.log &

# Systemd servisi oluştur
sudo bash -c 'cat > /etc/systemd/system/licserver.service <<EOF
[Unit]
Description=LicServer Node.js Application
After=network.target

[Service]
ExecStartPre=/usr/bin/pm2 stop licserver || true
ExecStart=/usr/bin/pm2 start /home/o11/o11v4/server.js --name licserver --silent
ExecStartPost=/home/o11/o11v4/o11_v4 -p 5555 &> /home/o11/o11v4/o11v4.log &
ExecStop=/usr/bin/pm2 stop licserver
Restart=always
User=o11
WorkingDirectory=/home/o11/o11v4
Environment=PATH=/usr/bin:/usr/local/bin
Environment=PM2_HOME=/home/o11/.pm2

[Install]
WantedBy=multi-user.target
EOF'

# Servisi etkinleştir ve başlat
sudo systemctl enable licserver
sudo systemctl start licserver

# Servis durumunu kontrol et
sudo systemctl status licserver
