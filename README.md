# Industrial Solutions & IoT Toolkit

> Repositório central de padrões de arquitetura, ferramentas de infraestrutura e interfaces para Indústria 4.0.

Este projeto consolida implementações práticas e ferramentas focadas na convergência **IT/OT** (Information Technology / Operational Technology), visando a interoperabilidade entre sistemas industriais e arquiteturas modernas de software.

## Estrutura do Projeto

O repositório está organizado em módulos funcionais, separando Infraestrutura de Interface:

```
applied-computing/

├── tools/                      # Infraestrutura & Backend
│   ├── automation/
│   │   └── linux/              # Scripts de Gestão de Arquivos (CRUD/Backup)
│   └── monitoring/
│       ├── linux/              # Scripts de Segurança e Redes (Bash)
│       ├── windows/            # Scripts PowerShell para SCADA
│       └── network/            # Scripts Python (Cross-platform)
│
└── web-dashboard/              # Frontend & HMI
    ├── index.html
    └── assets/
        ├── base.css
        ├── script.js
        └── styles.css
```

### Detalhamento dos Módulos

**1. Tools (Infraestrutura)**
Scripts de automação, monitoramento de servidores e utilitários de sistema.

* **automation/linux/**: Ferramentas de operação e manutenção.
    * Scripts de backup (`config_backup`), limpeza segura de disco (`interactive_cleanup`) e transferência de arquivos em lote (`batch_file_transfer`).

* **monitoring/linux/**: Diagnóstico e Cibersegurança (Bash).
    * Auditoria de logs (`auth_audit`), scanner de portas (`network_scan`) e verificação de vulnerabilidades (`os_vuln_check`).

* **monitoring/windows/**: Ferramentas para diagnóstico de servidores SCADA (PowerShell).
    * O script `server_health_check.ps1` unifica verificação de portas (Modbus/S7), processos críticos e logs de segurança.

* **monitoring/network/**: Diagnóstico de Conectividade e Aplicação (Python).
    * `site_monitor.py`: Ferramenta CLI modular para validar status de múltiplos endpoints (Web/IoT) com tratamento de erros.

**2. Web-Dashboard (Frontend)**
Interfaces Web aplicadas a contextos industriais.
* Protótipos de dashboards para visualização de dados.
* Testes de tecnologias Web (HTML/CSS/JS) para chão de fábrica.


---
*Desenvolvido por [engcontrol-alv](https://github.com/engcontrol-alv)*