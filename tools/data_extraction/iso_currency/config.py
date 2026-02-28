"""
Configurações Locais: iso-currency
Variáveis Globais apartadas do código (URL, Timeouts)
"""

# Endpoint de extração
URL_IBAN = "https://iban.com/currency-codes"

# Identificação para o SystemLogger (logger.py)
APP_NAME = "ISO-CURRENCY-SCRAPER"
LOG_FILENAME = "currency_extraction.log"

# Parâmetros de rede
REQUEST_TIMEOUT = 15