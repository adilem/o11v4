FROM node:lts

# Çalışma dizinine geç
WORKDIR /app

# Gerekli paketleri kur
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# pm2 yükle
RUN npm install -g pm2

# Projeyi klonla
RUN git clone https://github.com/adilem/o11v4 /app/o11v4

WORKDIR /app/o11v4

# Express kur ve dosyayı çalıştırılabilir yap
RUN npm install express
RUN chmod +x o11_v4

# Portu aç
EXPOSE 5555

# server.js ve o11_v4'ü aynı anda başlat
CMD pm2 start server.js --silent && ./o11_v4 -p 5555
