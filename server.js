const https = require('https');
const http = require('http');
const express = require('express');
const fs = require('fs');
const { exec } = require('child_process');

const app = express();
app.use(express.static('www'));

app.post('/lic', (req, res) => {
  res.sendFile('lic.cr', { root: __dirname });
});

const certPath = './certs', key = `${certPath}/key.pem`, cert = `${certPath}/cert.pem`;
if (!fs.existsSync(certPath)) fs.mkdirSync(certPath);
if (!fs.existsSync(key) || !fs.existsSync(cert))
  exec(`openssl req -x509 -newkey rsa:2048 -keyout ${key} -out ${cert} -days 365 -nodes -subj "/CN=localhost"`);

http.createServer(app).listen(5454);
https.createServer({ key: fs.readFileSync(key), cert: fs.readFileSync(cert) }, app).listen(4444);
