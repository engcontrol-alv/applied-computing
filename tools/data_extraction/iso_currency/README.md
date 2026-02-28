# ISO-4217 Currency Search Engine

## Overview
A data extraction and search tool for ISO-4217 currency codes. This project implements a modular architecture designed for scalability, reliability, and ease of maintenance in software environments.

## Key Features
- **Modular Design:** Complete separation between infrastructure (Shared Logging), configuration, and core logic (Scraper).
- **Quality Assurance:** Integrated test suite using Pytest, covering data structure integrity and network resilience.
- **Optimized Performance:** Single-fetch execution pattern with memory-based fuzzy search for fast user interaction.
- **Centralized Auditing:** Industrial-standard logging system with unique namespaces for traceability.

## Technical Stack
- Python 3.x
- BeautifulSoup4 (HTML Parsing)
- Requests (HTTP Client)
- Pytest (Unit Testing)

## Project Directory Tree
```
applied-computing/
│
├── tools/                          # Root for all system utilities
│   ├── __init__.py                 # Makes 'tools' a Python package
│   │
│   ├── shared/                     # GLOBAL REUSABLE MODULES
│   │   ├── __init__.py
│   │   └── logger.py               # Centralized SystemLogger for all projects
│   │
│   └── data_extraction/            # CATEGORY: Data Extraction Utilities
│       ├── __init__.py
│       └── iso_currency/           # PROJECT: ISO-4217 Currency Scraper
│           ├── __init__.py
│           ├── config.py           # Local settings (URLs, Timeouts)
│           ├── main.py             # App Orchestrator and User Interface
│           ├── scraper.py          # Extraction and Parsing Logic (BS4)
│           ├── test_scraper.py     # Automated QA Tests (Pytest)
│           ├── requirements.txt    # Project-specific dependencies
│           └── README.md           # Technical documentation
│
├── .venv/                          # Local Python Virtual Environment
├── currency_extraction.log         # Project-specific log file (runtime generated)
└── system_logs.log                 # General system log file (runtime generated)
```

## How to Run

1. **Install Dependencies:**
   pip install -r requirements.txt

2. **Execute Application:**
   python -m tools.data_extraction.iso_currency.main

3. **Run Tests:**
   $env:PYTHONPATH="."
   python -m pytest

## Architecture Patterns
This project follows the **Clean Code** principles and the **Separation of Concerns (SoC)** pattern, ensuring that the scraping logic remains independent from the user interface and logging services.