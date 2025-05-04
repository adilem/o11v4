# Temel görüntü olarak Ubuntu 22.04 kullanıyoruz
FROM ubuntu:22.04

# Çevresel değişkeni ayarla
ENV DEBIAN_FRONTEND=noninteractive

# curl ve gerekli paketleri kur
RUN apt-get update && apt-get install -y curl

# Node.js, PM2 ve Express'i kur
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g pm2 express \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Uygulama dosyalarını konteynıra kopyala
COPY server.js run.sh o11.cfg o11v4 lic.cr /home/o11/

# Çalıştırılabilir dosya izinlerini ver
RUN chmod +x /home/o11/run.sh /home/o11/o11v4 /home/o11/lic.cr

# SSL sertifikalarını oluştur
RUN mkdir -p /home/o11/certs && \
    openssl req -x509 -newkey rsa:2048 -keyout /home/o11/certs/key.pem -out /home/o11/certs/c.pem -days 365 -nodes -subj "/CN=localhost"

# Gereken portları aç
EXPOSE 80 443 5454 8484

# Çevresel değişkenleri ayarla
ENV SERVER_TYPE=nodejs
ENV IP_ADDRESS="127.0.0.1"

# Konteyner başladığında çalıştırılacak komut
CMD pm2 start server.js --name licserver --silent
