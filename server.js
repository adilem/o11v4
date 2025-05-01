const https = require('https');
const http = require('http');
const express = require('express');
const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

// Express Server Setup
const app = express();
app.use(express.static('www')); // 'www' klasörünü statik olarak sunuyoruz

// Handle POST /lic requests
app.post('/lic', (req, res) => res.sendFile('lic.cr', { root: __dirname }));

// SSL Certificate Generation
const certPath = './certs';
const keyFile = `${certPath}/key.pem`;
const certFile = `${certPath}/cert.pem`;

// Eğer sertifika dosyaları yoksa oluşturulurlar
if (!fs.existsSync(certPath)) fs.mkdirSync(certPath);
if (!fs.existsSync(keyFile) || !fs.existsSync(certFile)) {
    exec(`openssl req -x509 -newkey rsa:2048 -keyout ${keyFile} -out ${certFile} -days 365 -nodes -subj "/CN=localhost"`);
}

// Start HTTP and HTTPS Servers
http.createServer(app).listen(5454, () => console.log('HTTP server running on port 5454'));
https.createServer({ key: fs.readFileSync(keyFile), cert: fs.readFileSync(certFile) }, app).listen(4444, () => console.log('HTTPS server running on port 4444'));