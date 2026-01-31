# OT/IT Integration

> Central repository for architecture standards, infrastructure tools, and system integrations.

This project consolidates practical implementations and tools focused on **IT/OT Integration**, aiming for interoperability between operational systems and modern software architectures (Edge-to-Cloud).

## Project Structure

The repository is organized into functional modules, separating Infrastructure, Interfaces, and Intelligent Integrations:

```text
applied-computing/
│
├── integration/                # [NEW] Cloud & AI Integration Module
│   └── doc-analyst/            # Document Analysis Solution (Zero Trust)
│       ├── README.md           # Module-specific documentation
│       │
│       ├── backend/            # Processing Logic (Python/Localhost)
│       │   ├── main.py         # API Server (Flask Wrapper)
│       │   └── requirements.txt
│       │
│       └── frontend/           # Visual Interface (SPA)
│           ├── index.html      # Onyx Cover (Landing Page)
│           ├── home.css        # Cover Styles
│           ├── app.html        # Main Application (Clean Mode)
│           ├── style.css       # Application Styles
│           ├── script.js       # Client-side Logic
│           ├── perfil.jpg      # Assets
│           └── image_docAnl.jpg
│
├── tools/                      # Infrastructure & Backend (Legacy)
│   ├── automation/
│   │   └── linux/              # File Management Scripts (CRUD/Backup)
│   │       ├── config_backup.sh
│   │       ├── interactive_cleanup.sh
│   │       └── batch_file_transfer.sh
│   │
│   └── monitoring/
│       ├── linux/              # Security & Network Scripts (Bash)
│       │   ├── auth_audit.sh
│       │   ├── network_scan.sh
│       │   └── os_vuln_check.sh
│       │
│       ├── windows/            # PowerShell Scripts for SCADA
│       │   └── server_health_check.ps1
│       │
│       └── network/            # Python Scripts (Cross-platform)
│           └── site_monitor.py
│
└── web-dashboard/              # Frontend & HMI (Prototypes)
    ├── index.html
    └── assets/
        ├── base.css
        ├── script.js
        └── styles.css
```

## Module Details

### 1. Integration (GenAI & Cloud)
Edge modules integrating AI services with secure, modern architecture.

#### integration/doc-analyst/
Doc Analyst AI: Technical document analysis system using GenAI and OCR with Edge-to-Cloud architecture.

* **Core:** Google Gemini 1.5 Flash integration (Multimodal).

* **Security:** Zero Trust Architecture (Keys and files processed in memory, no server persistence).

* **Frontend:** Decoupled Web Interface featuring the "Onyx" design system.

* **Backend:**  Local Python API for secure data orchestration.

### 2. Tools (Infrastructure)
Automation scripts, server monitoring, and system utilities for operational environments.

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