#! /bin/bash

#Description: Verifica resposta HTTP e busca vulnerabilidade conehcidas (Shellshock teste)

read -p "Digite o site (ex.: https://www.google.com): " site
[ -z "$site" ] && site="https://www.google.com"

vulnerabilidade="CVE-2014-6271"

echo "Verificando $site..."
resultado=$(curl -s -I "$site" | grep "$vulnerabilidade")

if [ -n "$resultado" ]; then
	echo "[PERIGO] Vulnerabilidade $vulnerabilidade detectada!"
else
	echo "[OK] Site Seguro. Vulnerabilidade $vulnerabilidade não verificada."
fi
