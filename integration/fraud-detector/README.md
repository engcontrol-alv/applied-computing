# Azure Credit Card Validator & Data Extraction Pipeline

![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=for-the-badge&logo=Streamlit&logoColor=white)

Aplicação desenvolvida para automatizar a extração e validação de dados sensíveis de cartões de crédito, utilizando os serviços de Inteligência Artificial do Microsoft Azure. 

## Contexto de Negócio e Problema Resolvido

Em fluxos de onboarding digital, KYC (Know Your Customer) e prevenção à fraude, a validação manual de documentos e cartões físicos é um gargalo operacional. Erros de digitação ou o envio de artefatos inválidos geram atrito na jornada do cliente e aumentam a exposição a riscos financeiros.

**A Solução (PoC):**
Este repositório apresenta uma Prova de Conceito (Proof of Concept) de um pipeline automatizado que substitui a análise manual. O sistema é desenhado para:
1. Receber o artefato (imagem) de forma segura.
2. Isolar e armazenar o documento em infraestrutura de nuvem.
3. Processar a imagem via IA/OCR (Document Intelligence) em tempo real.
4. Retornar dados estruturados (Titular, Banco, Validade) para consumo de sistemas terceiros.

## Segurança e Privacidade
- **PCI DSS:** Esta aplicação não está em conformidade com as normas PCI DSS. Não utilize cartões reais em ambientes de produção sem a devida implementação de criptografia e conformidade.
- **Proteção de Dados:** O arquivo .env está configurado no .gitignore para não expor dados sensíveis no histórico de commits.
- **Limpeza de Dados:** Recomenda-se configurar políticas de retenção no Azure Blob Storage para excluir imagens após o processamento.

## Principais Funcionalidades
- **Extração Automática:** Identificação de número, titular, data de validade e instituição emissora.
- **Validação em Nuvem:** Armazenamento automático em Azure Blob Storage para logs de auditoria.
- **Análise de Confiança:** Retorno do índice de precisão da IA para cada campo extraído.
- **Interface Intuitiva:** Dashboard desenvolvido em Streamlit para upload facilitado via Drag & Drop.

## Arquitetura e Tecnologias
- **Interface de Usuário:** Python + Streamlit para prototipagem da interface de upload.
- **Camada de Armazenamento:** Azure Blob Storage (blob_service.py).
- **Camada de Inteligência:** Azure AI Document Intelligence (credit_card_service.py), utilizando o modelo pré-treinado "prebuilt-creditCard".

### Exemplo de Saída (JSON)
```json
{
  "card_holder": "NOME DO TITULAR",
  "card_number": "0000 0000 0000 0000",
  "expiry_date": "MM/AA",
  "bank_name": "BANCO EMISSOR",
  "confidence_score": 0.98
}
```

## Estrutura do Repositório

```text
fraud-detector/
├── src/
│   ├── app.py
│   ├── services/
│   │   ├── blob_service.py
│   │   └── credit_card_service.py
│   └── utils/
│       └── Config.py
├── .env.example
├── .gitignore
├── requirements.txt
└── README.md
```

## Instruções de Instalação e Execução
### Pré-requisitos
- Python 3.9 ou superior.

- Credenciais ativas do Microsoft Azure (Storage Account e Document Intelligence Resource).

### Configuração do Ambiente
1. Clone o repositório e acesse a pasta:

```bash
git clone https://github.com/engcontrol-alv/applied-computing.git
cd applied-computing/integration/fraud-detector
```

2. Configure as variáveis de ambiente:
```bash
cp .env.example .env
```

3. Configure as variáveis de ambiente:
Crie um arquivo .env na raiz do projeto utilizando o comando abaixo ou preenchendo as chaves manualmente:

```bash
cp .env.example .env
```

- O arquivo deve conter as seguintes chaves obtidas no Portal Azure:

```env
ENDPOINT="seu_endpoint_azure_document_intelligence"
SUBSCRIPTION_KEY="sua_chave_azure_document_intelligence"
AZURE_STORAGE_CONNECTION_STRING="sua_connection_string_storage_account"
CONTAINER_NAME="seu_nome_de_container"
```


4. Instale as dependências e execute:
```bash
pip install -r requirements.txt
```

5. Inicialize a aplicação localmente:

```Bash
streamlit run src/app.py
```

---
*Developed by [engcontrol-alv](https://github.com/engcontrol-alv)*