#!/bin/bash
# Description: Auditoria de tentativas de login falhas (Requer sudo)

# 1. Verifica se o usuário é ROOT (EUID 0)
if [ "$EUID" -ne 0 ]; then
	echo "Erro: Este script requer permissão de administrador para ler os logs."
	echo "Por favor, execute com: sudo ./auth_audit.sh"
	exit 1
fi

log_file="/var/log/auth.log" 
limite_tentativas=5


if [ ! -f "$log_file" ]; then
    echo "Erro: Arquivo $log_file não encontrado."
    exit 1
fi

echo "Analisando log: $log_file"

# 2. Executa varredura
tentativas=$(grep -c "Failed password" "$log_file" || echo 0)

echo "Tentativas de falhas detectadas: $tentativas"

if [ "$tentativas" -ge "$limite_tentativas" ]; then
    echo "[ALERTA] Possível ataque de força bruta detetado!"
else
    echo "[SEGURO] Nenhuma atividade suspeita."
fi
