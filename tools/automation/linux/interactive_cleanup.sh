#!/bin/bash

# Configurações iniciais
BACKUP_ENABLED="true"  # Mude para "false" para desativar backups automáticos
BACKUP_DIR="./backups_deletados"  # Diretório para backups (criado automaticamente)

deletar_arquivos_da_lista() {
    local temp_file="$1"  # Nome do arquivo temporário com a lista dos arquivos

    # Verifica se o argumento foi fornecido
    if [ -z "$temp_file" ]; then
        echo "Uso: $0 <arquivo_com_lista.txt>"
        return 1
    fi

    # Verifica se o arquivo de lista existe
    if [ ! -f "$temp_file" ]; then
        echo "Erro: Arquivo '$temp_file' não encontrado!"
        return 1
    fi

    # Cria diretório de backup se ativado
    if [ "$BACKUP_ENABLED" = "true" ]; then
        mkdir -p "$BACKUP_DIR" || {
            echo "Erro: Não foi possível criar o diretório de backup '$BACKUP_DIR'"
            return 1
        }
    fi

    echo "Iniciando deleção dos arquivos listados em '$temp_file'..."

    # Contadores para relatório final
    local sucessos=0
    local falhas=0

    # Loop: lê cada linha do arquivo e armazena na variável file_name
    while IFS= read -r file_name || [ -n "$file_name" ]; do
        # Remove espaços em branco extras e quebras de linha
        file_name=$(echo "$file_name" | xargs)

        # Ignora linhas vazias após limpeza
        if [ -z "$file_name" ]; then
            continue
        fi

        # Verifica se o arquivo existe
        if [ -f "$file_name" ]; then
            # Faz backup se ativado
            if [ "$BACKUP_ENABLED" = "true" ]; then
                local backup_path="$BACKUP_DIR/$(basename "$file_name")_$(date +%Y%m%d_%H%M%S)"
                if cp "$file_name" "$backup_path"; then
                    echo "[BACKUP] Criado: '$backup_path'"
                else
                    echo "[AVISO] Falha ao criar backup para: '$file_name'"
                    ((falhas++))
                    continue
                fi
            fi

            # Tenta deletar o arquivo
            if rm "$file_name"; then
                echo "[SUCESSO] Deletado: '$file_name'"
                ((sucessos++))
            else
                echo "[FALHA] Não foi possível deletar: '$file_name'"
                ((falhas++))
            fi
        else
            echo "[AVISO] Arquivo não encontrado: '$file_name'"
            ((falhas++))
        fi
    done < "$temp_file"

    echo "Relatório final:"
    echo "- Arquivos deletados com sucesso: $sucessos"
    echo "- Arquivos com problemas: $falhas"
    if [ "$BACKUP_ENABLED" = "true" ]; then
        echo "- Backups salvos em: '$BACKUP_DIR'"
    fi
    echo "Operação concluída."
}

# Chama a função principal com o argumento fornecido
deletar_arquivos_da_lista "$1"
