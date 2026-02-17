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
3. Processar a imagem via IA generativa/OCR (Document Intelligence) em tempo real.
4. Retornar dados estruturados (Titular, Banco, Validade) para consumo de sistemas terceiros (ERP, CRM ou motor de fraude).

## Arquitetura e Tecnologias

A solução foi projetada com foco em escalabilidade e separação de responsabilidades (Frontend, Storage e Processamento):

- **Interface de Usuário:** Python + Streamlit para prototipagem da interface de upload.
- **Camada de Armazenamento:** Azure Blob Storage (`blob_service.py`), garantindo retenção segura do arquivo original para fins de auditoria.
- **Camada de Inteligência:** Azure AI Document Intelligence (`credit_card_service.py`), utilizando o modelo pré-treinado "prebuilt-creditCard" para extração estruturada e análise de confiabilidade dos dados.

## Estrutura do Repositório

```bash
fraud-detector/
├── src/
│   ├── app.py
│   ├── services/
│   │   ├── blob_service.py
│   │   └── credit_card_service.py
│   └── utils/
│       └── Config.py
├── .env
├── .gitignore
├── requirements.txt
└── README.md
```

## Instruções de Instalação e Execução
### Pré-requisitos
- Python 3.9 ou superior.

- Credenciais ativas do Microsoft Azure (Storage Account e Document Intelligence Resource).

### Configuração do Ambiente
1. Clone o repositório:

```bash
git clone https://github.com/engcontrol-alv/fraud-detector.git
cd fraud-detector
```
2. Crie e ative um ambiente virtual:

```bash
python -m venv venv
```
# Windows:
```bash
venv\Scripts\activate
```
# Linux/Mac:
```bash
source venv/bin/activate
```
3. Instale as dependências listadas:

```bash
pip install -r requirements.txt
```
4. Configure as variáveis de ambiente:
Crie um arquivo .env na raiz do projeto contendo as seguintes chaves de integração:

```env
ENDPOINT="seu_endpoint_azure_document_intelligence"
SUBSCRIPTION_KEY="sua_chave_azure_document_intelligence"
AZURE_STORAGE_CONNECTION_STRING="sua_connection_string_storage_account"
CONTAINER_NAME="seu_nome_de_container"
```
5. Inicialize a aplicação localmente:

```Bash
streamlit run src/app.py
```

---
*Developed by [engcontrol-alv](https://github.com/engcontrol-alv)*