#!/bin/bash

copiar_arquivos_da_lista() {
  # Prompt para o arquivo com a lista
  echo "Digite o caminho completo ou relativo para o arquivo que contém a lista de arquivos a serem copiados (ex: lista.txt):"
  read -r temp_file
  
  # Verifica se o arquivo de lista foi informado e existe
  if [ -z "$temp_file" ] || [ ! -f "$temp_file" ] || [ ! -r "$temp_file" ]; then
    echo "Erro: Arquivo '$temp_file' não encontrado, vazio ou sem permissão de leitura!"
    return 1
  fi

  # Prompt para o diretório de destino
  echo "Digite o caminho completo ou relativo para o diretório de destino (ex: ./copias ou /tmp/backups):"
  read -r destino_dir
  
  # Verifica se o diretório de destino foi informado
  if [ -z "$destino_dir" ]; then
    echo "Erro: Nenhum diretório de destino informado!"
    return 1
  fi

  # Garante que o diretório existe
  mkdir -p "$destino_dir" || {
    echo "Erro: Não foi possível criar o diretório '$destino_dir'"
    return 1
  }

  echo "Iniciando cópia dos arquivos listados em '$temp_file' para '$destino_dir'..."

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

    # Verifica se o arquivo existe e é copiável
    if [ -f "$file_name" ]; then
      if cp "$file_name" "$destino_dir"; then
        echo "[SUCESSO] Copiado: '$file_name'"
        ((sucessos++))
      else
        echo "[FALHA] Não foi possível copiar: '$file_name' (verifique permissões ou espaço em disco)"
        ((falhas++))
      fi
    else
      echo "[AVISO] Arquivo não encontrado: '$file_name'"
      ((falhas++))
    fi
  done < "$temp_file"

  echo "Relatório final:"
  echo "- Arquivos copiados com sucesso: $sucessos"
  echo "- Arquivos com problemas: $falhas"
  echo "Operação concluída."
}

# Chama a função principal (sem necessidade de argumentos, pois é interativo)
copiar_arquivos_da_lista
