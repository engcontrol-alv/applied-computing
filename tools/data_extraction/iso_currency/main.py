from tools.shared.logger import setup_logger
from tools.data_extraction.iso_currency.config import URL_IBAN, APP_NAME, REQUEST_TIMEOUT
from tools.data_extraction.iso_currency.scraper import fetch_iso_data

# O log agora é instanciado para gravar apenas no arquivo oculto .currency_extraction.log
# show_console por padrão é False, limpando a tela do usuário
log = setup_logger(APP_NAME)

def exibir_tela_inicial():
    print("-" * 45)
    print("      Bem-vindo       ")
    print("-" * 45)
    print("Escolha pelo numero da lista o pais que deseja consultar o código da moeda.\n")

def main():
    # Esta mensagem irá apenas para o arquivo .currency_extraction.log
    log.info("--- ISO-4217 SESSION START ---")
    
    currency_data = fetch_iso_data(URL_IBAN, REQUEST_TIMEOUT)

    if not currency_data:
        print("Erro: Nao foi possivel carregar a base de dados.")
        return

    exibir_tela_inicial()

    # Listagem numerada conforme o propósito original
    for i, registro in enumerate(currency_data, 1):
        print(f"#{i} {registro['Country'].title()}")

    while True:
        try:
            print("\n" + "-"*45)
            entrada = input("Digite o numero (ou 'exit'): ").strip()
            
            if entrada.lower() == 'exit':
                break

            numero = int(entrada)
            if 1 <= numero <= len(currency_data):
                pais = currency_data[numero - 1]
                print(f"\nSucesso: {pais['Country'].title()} -> Codigo: {pais['Code']}")
            else:
                print("Numero fora da lista.")
        
        except ValueError:
            print("Por favor, digite um numero valido.")

    log.info("--- ISO-4217 SESSION END ---")

if __name__ == "__main__":
    main()