# Network Availability Monitor

[![pt-br](https://img.shields.io/badge/lang-pt--br-green.svg)](README.pt-br.md)

A lightweight, modular Python CLI tool designed for network diagnostics and connectivity checks. It validates the status of multiple endpoints (Websites, APIs, PLCs), handling timeouts and HTTP status codes robustly.

## Features
- **Bulk Check:** Accepts comma-separated URLs via CLI.
- **Resilient:** Handles Timeouts, Connection Errors, and SSL Handshakes.
- **Standardized Output:** Clean, log-friendly format `[TAG] Message`.

## How to Run

### 1. Install Dependencies
```bash
pip install -r requirements.txt
```

### 2. Execute
```bash
python site_monitor.py
```