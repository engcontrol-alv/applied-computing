import pytest
from tools.data_extraction.iso_currency.scraper import fetch_iso_data
from tools.data_extraction.iso_currency.config import URL_IBAN

def test_fetch_iso_data_returns_list():
    """Testa se a função retorna uma lista"""
    data = fetch_iso_data(URL_IBAN, timeout=10)
    assert isinstance(data, list)
    assert len(data) > 0

def test_data_structure():
    """Testa se os dicionarios têm as chaves obrigatórias"""
    data = fetch_iso_data(URL_IBAN, timeout=10)
    first_item = data[0]
    assert "Country" in first_item
    assert "Code" in first_item

def test_invalid_url():
    """Testa se o sistema lida bem com URLs erradas sem quebrar"""
    data = fetch_iso_data("https://url-que-nao-existe.com", timeout=1)
    assert data == []