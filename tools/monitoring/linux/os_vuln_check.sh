#! /bin/bash
# Description: Verifica se a versão do SO consta numa base de dados de vulnerabilidades (CVE)

# 1. Identifica o Sistema Operacional atual
if [ -f /etc/os-release ]; then
	# Extrai o nome e versão
	. /etc/os-release
	sistema_atual="$NAME $VERSION_ID"
else
	sistema_atual="Desconhecido"
fi

echo "Sistema detectado: $sistema_atual"

# 2. Cria uma base de dados simulada (Mock DB) para demonstração
database_file=".cve_database_mock.txt"
echo "Ubuntu 18.04:CVE-2019-1234 (End of Life)" > "$database_file"
echo "Ubuntu 20.04:CVE-2021-5678 (Kernel Bug)" >> "$database_file"
echo "Debian 10:CVE-2022-9999 (Old Stable)" >> "$database_file"

echo "Consultando base de dados de vulnerabilidades..."


# 3. Verifica se o sistema atual está na lista
vulnerabilidade=$(grep "$sistema_atual" "$database_file")


if [ -n "$vulnerabilidade" ]; then
	echo "----------------------------------------------"
	echo "[PERIGO] O sistema ($sistema_atual) está vulnerável!."
	echo "Detalhe: $vulnerabilidade"
	echo "----------------------------------------------"
else
	echo "[SEGURO] Nenhuma vulnerabilidade conhecida encontrada"
fi

# Limpeza do arquivo temporário
rm "$database_file"
