# Tech Translator CLI

A command-line interface tool for translating technical documentaion within the OT/IT context. It utilizes **Google Gemini 1.5 Flash** to ensure high fidelity for engineering terminology, preserving keywords like "deploy", "pipeline", and "SCADA" in their original English forms while translating the context.

## Architecture

- **Engine:** LangChain + Google Gemini
- **Interface:** CLI (Command Line Interface)
- **Secutiry:** Environment variable management for API Keys

## Usage

1. Navigate to the directory:
    ```bash
    cd integration/tech-translator
    ```

2. Install dependencies:
    ```bash
    pip install -r requirements.txt
    ```
    
3. Configure credentials: Create a .env file with GOOGLE_API_KEY=your_key.

4. Run:
    ```bash
    python translator.py
    ```

Paste the text you want to translate and press Ctrl+D (Linux/Mac) or Ctrl+Z (Windows) to submit.

#### 5. Configure Security (Root)
Make sure the `.gitgnore` file in the **root** directory (`applied-computing/.gitignore`) contains the `.env` line. If it already does, it will automatically protect the new folder.

#### 6. Update the Main README
Now, go to the `applied-computing/README.md` file (the main one) and update the **Module Details** section to include this new tool:

```markdown
(Previous content...)

1. Integration (GenAI & Cloud)

Edge modules integrating AI services with secure, modern architecture.

**integration/doc-analyst/**
Doc Analyst AI: Technical document analysis system using GenAI and OCR...

**integration/tech-translator/**
Tech Translator CLI: Automated translation tool designed for engineering documentation.
Core: Google Gemini 1.5 Flash via langChain.
Features: Context-aware translation that strictly preserves technical jargon and code blocks.

(content to follow)

