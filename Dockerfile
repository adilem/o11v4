# Temel imaj olarak Ubuntu 20.04 kullanalım
FROM ubuntu:20.04

# Zaman dilimi ve etkileşimli kurulumdan kaçınmak için bu satırı ekliyoruz
ENV DEBIAN_FRONTEND=noninteractive

# Gerekli paketleri yükleyelim
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    nodejs \
    npm \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Node.js ve PM2'yi kuruyoruz
RUN npm install -g pm2 \
    && npm install express

# Gerekli dizinleri oluşturuyoruz
RUN mkdir -p /home/o11

# Çalışma dizini olarak /home/o11'i belirliyoruz
WORKDIR /home/o11

# Repo'yu klonlayalım
RUN git clone https://github.com/adilem/o11v4

# PM2 ile sunucuyu başlatmak için server.js dosyasına geçelim
WORKDIR /home/o11/o11v4

# PM2 ile server.js'i başlatıyoruz
RUN pm2 start server.js --name licserver --silent

# PM2'yi boot'ta başlatacak şekilde yapılandırıyoruz
RUN pm2 startup \
    && pm2 save

# o11_v4 dosyasını çalıştırılabilir hale getiriyoruz
RUN chmod +x /home/o11/o11v4/o11_v4

# Docker konteyneri çalıştığında o11_v4'i arka planda çalıştırıyoruz
CMD ["bash", "-c", "nohup ./o11_v4 -p 5555 &> /home/o11/o11v4/o11v4.log &"]
