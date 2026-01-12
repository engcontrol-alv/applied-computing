#!/bin/bash

mover_arquivos_da_lista() {
  local temp_file="$1"       # Nome do arquivo com lista de arquivos
  local destino_dir="./scripts"  # Diretório de destino
  
  # Garante que o diretório existe
  mkdir -p "$destino_dir" || {
    echo "Erro: Não foi possível criar o diretório '$destino_dir'"
    return 1
  }

  echo "Iniciando movimentação dos arquivos listados em '$temp_file'..."

  # Verifica se o arquivo de lista existe e é legível
  if [ ! -f "$temp_file" ] || [ ! -r "$temp_file" ]; then
    echo "Erro: Arquivo '$temp_file' não encontrado ou sem permissão de leitura!"
    return 1
  fi

  # Contadores para relatório final
  local sucessos=0
  local falhas=0

  # Loop para ler cada linha do arquivo
  while IFS= read -r file_name || [ -n "$file_name" ]; do
    # Remove espaços em branco extras e quebras de linha
    file_name=$(echo "$file_name" | xargs)
    
    # Ignora linhas vazias após limpeza
    if [ -z "$file_name" ]; then
      continue
    fi

    # Verifica se o arquivo existe e é movível
    if [ -f "$file_name" ]; then
      if mv "$file_name" "$destino_dir"; then
        echo "[SUCESSO] Movido: '$file_name'"
        ((sucessos++))
      else
        echo "[FALHA] Não foi possível mover: '$file_name' (verifique permissões ou espaço em disco)"
        ((falhas++))
      fi
    else
      echo "[AVISO] Arquivo não encontrado: '$file_name'"
      ((falhas++))
    fi
  done < "$temp_file"

  echo "Relatório final:"
  echo "- Arquivos movidos com sucesso: $sucessos"
  echo "- Arquivos com problemas: $falhas"
  echo "Operação concluída."
}

# Verifica se o argumento foi passado (nome do arquivo temporário)
if [ $# -ne 1 ]; then
  echo "Uso: $0 <arquivo_com_lista.txt>"
  exit 1
fi

# Chama a função com o argumento fornecido
mover_arquivos_da_lista "$1"
