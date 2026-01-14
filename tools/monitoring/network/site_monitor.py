#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Network Availability Monitor
----------------------------
Author: Alvaro Luiz
Date:   January 2026
Version: 1.0

Description:
    A modular command-line tool designed to verify the connectivity status 
    of multiple websites or IP addresses. It handles HTTP/HTTPS requests, 
    manages timeouts, and categorizes status codes (200 OK, 404, etc.).

Usage:
    python site_monitor.py
    (Then follow the interactive prompts)

Dependencies:
    - requests
"""

import requests
import sys

# Lista de status considerados "Sucesso" na verificação
# Nota: 404 indica que o servidor está online, embora o recurso não exista.
HTTP_ONLINE_STATUS = [200, 404, 301, 302, 303]

def get_websites_from_user():
    """Pede ao usuário as URLs e retorna uma lista limpa."""
    print("\nInsira as URLs para verificação (separadas por vírgula):")
    print("Ex: google.com, 192.168.0.1, http://meusite.com")
    websites_input = input("URLs: ")
    
    # Divide por vírgula e remove espaços em branco de cada item
    websites_list = [url.strip() for url in websites_input.split(',') if url.strip()]
    return websites_list

def check_connectivity(websites_to_check):
    """Verifica a conectividade de cada URL na lista."""
    print("\n--- Iniciando Diagnóstico de Rede ---")
    
    for website_url in websites_to_check:
        full_url = website_url
        # Verifica se a URL já começa com http:// ou https://
        if not website_url.startswith("http://") and not website_url.startswith("https://"):
            full_url = "https://" + website_url # Assume HTTPS por padrão
            
        try:
            # Timeout: 3s para conectar, 10s para leitura (Evita travar o script)
            response = requests.get(full_url, timeout=(3, 10))
            
            if response.status_code in HTTP_ONLINE_STATUS:
                print(f"[ONLINE] {website_url} -> Status: {response.status_code}")
            else:
                print(f"[ERRO]   {website_url} -> Status: {response.status_code}")
                
        except requests.exceptions.MissingSchema:
            print(f"[FALHA]  {website_url}: URL mal formatada.")
        except requests.exceptions.ConnectionError:
            print(f"[OFFLINE] {website_url}: Não foi possível conectar ao host.")
        except requests.exceptions.Timeout:
            print(f"[TIMEOUT] {website_url}: Tempo limite excedido.")
        except Exception as e:
            print(f"[CRASH]   {website_url}: Erro desconhecido: {e}")
            
    print("-------------------------------------\n")

def ask_to_continue():
    """Pergunta ao usuário se deseja continuar e retorna True/False."""
    while True:
        choice = input("Nova verificação? (s/n): ").lower().strip()
        if choice == 's':
            return True
        elif choice == 'n':
            print("Encerrando monitoramento. Até logo!")
            return False
        else:
            print("Opção inválida. Digite 's' ou 'n'.")

def main():
    """Função principal (Entry Point)."""
    print("========================================")
    print("   INDUSTRIAL NETWORK MONITOR v1.0      ")
    print("========================================")

    should_continue = True
    while should_continue:
        websites = get_websites_from_user()

        if websites:
            check_connectivity(websites)
        else:
            print(">> Nenhuma URL válida fornecida.")

        should_continue = ask_to_continue()

if __name__ == "__main__":
    main()