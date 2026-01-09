# Industrial Solutions & IoT Toolkit

> Repositório central de padrões de arquitetura, ferramentas de infraestrutura e interfaces para Indústria 4.0.

Este projeto consolida implementações práticas e ferramentas focadas na convergência **IT/OT** (Information Technology / Operational Technology), visando a interoperabilidade entre sistemas industriais e arquiteturas modernas de software.

## Estrutura do Projeto

O repositório está organizado em módulos funcionais, separando Infraestrutura de Interface:

```
applied-computing/
├── tools/                      # Infraestrutura & Backend
│   └── monitoring/
│       └── windows/
│           └── server_health_check.ps1
│
└── web-dashboard/              # Frontend & HMI
    ├── index.html
    └── assets/
        ├── base.css
        ├── script.js
        └── styles.css
```

Detalhamento dos Módulos


1. Tools (Infraestrutura) Scripts de automação, monitoramento de servidores e utilitários de sistema.
    •monitoring/windows/: Ferramentas para diagnóstico de servidores SCADA. O script server_health_check.ps1 unifica verificação de portas (Modbus/S7), processos críticos e logs de segurança.

2. Web-Dashboard (Frontend) Interfaces Web aplicadas a contextos industriais.
    •Protótipos de dashboards para visualização de dados.
    •Testes de tecnologias Web (HTML/CSS/JS) para chão de fábrica.

Tecnologias e Conceitos
    •Automação de OS: PowerShell (Windows), Bash (Linux).
    •Web Industrial: HTML5, CSS3, JavaScript.
    •Protocolos: Modbus, MQTT.
    •Metodologia: DevOps aplicado à Automação Industrial.


Desenvolvido por engcontrol-alv