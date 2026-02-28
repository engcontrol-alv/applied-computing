import requests
from bs4 import BeautifulSoup
from typing import List, Dict
from tools.shared.logger import setup_logger
from .config import APP_NAME

log = setup_logger(f"{APP_NAME}.SCRAPER")

def fetch_iso_data(url: str, timeout: int) -> List[Dict[str, str]]:
    """
    Realiza o web scrapping e retorna uma lista de dicionários formatados.
    """
    try:
        log.info(f"Iniciando requisição GET para {url}")
        response = requests.get(url, timeout=timeout)
        response.raise_for_status()

        soup = BeautifulSoup(response.text, 'html.parser')
        table = soup.find("table")

        if not table:
            log.error("Tabela não encontrada na página de destino.")
            return []
        
        rows = table.find_all("tr")
        if not rows:
            return []
        
        # Extração dinâmica de cabeçalhos
        headers = [th.text.strip() for th in rows[0].find_all(["th", "td"]) if th.text.strip()]

        results = []

        for row in rows[1:]:
            cols = row.find_all("td")
            if len(cols) >= len(headers):
                entry = {headers[i]: cols[i].text.strip() for i in range(len(headers))}
                results.append(entry)

        log.info(f"Extração bem-sucedida: {len(results)} registros processados.")
        return results
    
    except requests.exceptions.RequestException as e:
        log.error(f"Erro de rede durante o scraping: {e}")
        return []
    except Exception as e:
        log.error(f"Erro inesperado no parser: {e}")
        return []