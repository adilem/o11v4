FROM debian:bullseye

# Çalışma dizini
WORKDIR /home/o11/

# Gerekli paketleri kur, Node.js, pm2 ve express'i yükle
RUN apt-get update && \
    apt-get install -y curl git openssl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pm2 express

# Repoyu klonla
RUN git clone https://github.com/adilem/o11v4.git

# Proje dizinine geç
WORKDIR /home/o11/o11v4

# o11_v4 dosyasını çalıştırılabilir yap
RUN chmod +x o11_v4

# Gerekli portları aç
EXPOSE 5454 4444 5555

# Sunucuları başlat
CMD pm2 start server.js --name licserver --silent && \
    ./o11_v4 -p 5555 && \
    tail -f /dev/null
