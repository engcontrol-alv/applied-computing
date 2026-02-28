# OT/IT Integration

> Central repository for architecture standards, infrastructure tools, and system integrations.

This project consolidates practical implementations and tools focused on **IT/OT Integration**, aiming for interoperability between operational systems and modern software architectures (Edge-to-Cloud).

## Project Structure

The repository is organized into functional modules, separating Infrastructure, Interfaces, and Intelligent Integrations:

```text
applied-computing/
│
├── index.html                  # Root Redirector -> Web Dashboard
├── README.md                   # Main Documentation
├── .gitignore                  # Global Git ignore rules
│
├── integration/                # Cloud & AI Integration Module
│   ├── doc-analyst/            # Document Analysis Solution (Zero Trust)
│   │   ├── README.md
│   │   ├── backend/            # Processing Logic (Python/Flask)
│   │   │   ├── main.py
│   │   │   └── requirements.txt
│   │   └── frontend/           # Visual Interface (SPA)
│   │       ├── .gitignore
│   │       ├── anotacoes.txt
│   │       ├── app.html
│   │       ├── script.js
│   │       └── style.css
│   │
│   ├── fraud-detector/         # Anti-Fraud Engine (Azure AI)
│   │   ├── README.md
│   │   ├── .env.example        # Environment variables template
│   │   ├── .gitignore
│   │   ├── requirements.txt
│   │   └── src/                # Core Application Logic
│   │       ├── app.py          # Entry Point (Streamlit)
│   │       ├── services/       # Azure Services Integration
│   │       │   ├── blob_service.py
│   │       │   └── credit_card_service.py
│   │       └── utils/
│   │           └── Config.py   # Configuration Manager
│   │
│   └── tech-translator/        # Technical Translator (Python + LangChain)
│       ├── README.md
│       ├── requirements.txt
│       └── translator.py       # CLI Application
│
├── tools/                      # Infrastructure & Backend
│   ├── automation/
│   │   └── linux/              # Operations & Maintenance Tools
│   │       ├── batch_file_transfer.sh
│   │       ├── config_backup.sh
│   │       └── interactive_cleanup.sh
│   │
│   ├── data_extraction/        # Data Acquisition & Parsing
│   │   └── iso_currency/       # ISO-4217 Currency Search Engine
│   │
│   ├── shared/                 # Core Infrastructure Modules
│   │   └── logger.py           # Industrial Logging System (Traceability)
│   │
│   └── monitoring/
│       ├── linux/              # Security & Diagnostics (Bash)
│       │   ├── auth_audit.sh
│       │   ├── network_scan.sh
│       │   ├── os_vuln_check.sh
│       │   └── web_health_check.sh
│       │
│       ├── network/            # Connectivity Diagnostics (Python)
│       │   ├── README.md
│       │   ├── README.pt-br.md
│       │   ├── requirements.txt
│       │   └── site_monitor.py
│       │
│       └── windows/            # SCADA/OT Health Checks (PowerShell)
│           └── server_health_check.ps1
│
└── web-dashboard/              # Portfolio Hub & Interface Styles
    ├── index.html              # Onyx Hub (Main Entry Point)
    ├── home.css
    └── assets/                 # Shared Media Resources
        ├── doc-analyst-preview.jpg
        └── perfil.jpg
```

## Module Details

### 1. Integration (GenAI & Cloud)
Edge modules integrating AI services with secure, modern architecture.

#### integration/fraud-detector/
* **Anti-Fraud Engine:** Intelligent validation system using Azure AI Document Intelligence and Azure Blob Storage.

* **Core:** (`credit_card_service.py`) for OCR and data extraction using the prebuilt-creditCard model.

* **Storage:** (`blob_service.py`) for document orchestration.

* **Interface:** Streamlit dashboard for interactive uploads.

#### integration/doc-analyst/
Doc Analyst AI: Technical document analysis system using GenAI and OCR with Edge-to-Cloud architecture.

* **Core:** Google Gemini 1.5 Flash integration (Multimodal).

* **Security:** Zero Trust Architecture (Keys and files processed in memory, no server persistence).

* **Frontend:** Decoupled Web Interface featuring the "Onyx" design system.

* **Backend:**  Local Python API for secure data orchestration.

#### integration/tech-translator/
Tech Translator CLI: Automated translation tool optimized for engineering documentation using Large Language Models.

* **Core:** Python + LangChain orchestration using Google Gemini 1.5 Flash.

* **Features:** Context-aware translation that strictly preserves technical jargon (e.g., "deploy", "pipeline") and Markdown formatting.

* **Security:** Environment variable management (.env) for API key protection.

### 2. Tools (Infrastructure)
Automation scripts, server monitoring, and system utilities for operational environments.

#### data_extraction/iso_currency/
ISO-4217 Currency Search Engine. A professional-grade tool for currency code identification featuring a modular scraper and integrated Pytest QA.

#### shared/logger/
Standardized industrial logging system. Provides centralized auditing and traceability for all modules, featuring multi-handler support for hidden logs and clean user interfaces.

#### automation/linux/
Operations and maintenance tools.

* Backup scripts (`config_backup.sh`), secure disk wiping (`interactive_cleanup.sh`), and batch file transfer (`batch_file_transfer.sh`).

#### monitoring/linux/
Diagnostics & Cybersecurity (Bash).

* Log auditing (`auth_audit.sh`), port scanner (`network_scan.sh`), and vulnerability checks (`os_vuln_check.sh`).

#### monitoring/windows/
Diagnostics tools for SCADA/OT servers (PowerShell).

* The `server_health_check.ps1` script unifies port verification, critical processes, and security logs.

#### monitoring/network/
Connectivity & Application Diagnostics (Python).

* `site_monitor.py`: Modular CLI tool to validate the status of multiple endpoints (Web/IoT) with error handling.

### 3. Web-Dashboard (Frontend)
Web interfaces applied to operational contexts.

* Dashboard prototypes for data visualization.

* Web technology tests (HTML/CSS/JS) for operational dashboards.

---
*Developed by [engcontrol-alv](https://github.com/engcontrol-alv)*