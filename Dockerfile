# Temel imaj olarak Ubuntu'yu kullan
FROM ubuntu:20.04

# Çalışma dizinini oluştur
WORKDIR /home/o11/

# Zaman dilimi seçiminden kaçınmak için DEBIAN_FRONTEND=noninteractive kullanıyoruz
ENV DEBIAN_FRONTEND=noninteractive

# Gerekli paketleri yükleyelim
RUN apt-get update && \
    apt-get install -y curl git sudo nodejs npm tzdata && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    npm install -g pm2 && \
    npm install express

# Repo'yu klonla
RUN git clone https://github.com/adilem/o11v4

# o11v4 dizinine geç
WORKDIR /home/o11/o11v4

# PM2 ile sunucuyu başlat
RUN pm2 start server.js --name licserver --silent

# PM2'yi boot'ta başlatacak şekilde yapılandır
RUN pm2 startup && \
    pm2 save

# o11_v4 dosyasını çalıştırılabilir hale getir
RUN chmod +x o11_v4

# o11_v4'i arka planda çalıştırmak için uygun komut
CMD ["nohup", "./o11_v4", "-p", "5555", "&>", "/home/o11/o11v4/o11v4.log", "&"]
