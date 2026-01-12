
#! /bin/bash

host="127.0.0.1"
portas=("80" "22" "443")

echo "Iniciando scan em $host..."

for porta in "${portas[@]}";do
	nc -zv -w 1 "$host" "$porta" > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "[ABERTA] Porta $porta"
	else
		echo "[FECHADA] Porta $porta"
	fi
done
