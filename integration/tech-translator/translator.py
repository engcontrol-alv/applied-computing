import os
import sys 
from typing import Optional
from langchain_google_genai import ChatGoogleGenerativeAI
from dotenv import load_dotenv

# Load enviroment variables
load_dotenv()

# API Key Validation
api_key = os.getenv("GOOGLE_API_KEY")

if not api_key:
    print("Error: API Key not found. Please check your .env file.")
    sys.exit(1)

# Model Initialization
try:
    llm = ChatGoogleGenerativeAI(
        model="models/gemini-2.5-flash",
        google_api_key=api_key,
        temperature=0.1
    )
except Exception as e:
    print(f"Error initialization model: {e}")
    sys.exit(1)

def translate_article(text: str, target_language: str) -> Optional[str]:
    """
    Translates technical text while preserving specific terminology.

    Args:
        text (str): The original text to be translated.
        target_language (str): The target language.
    
    Returns:
        str: The translated text in Markdown format._
    
    """

    print(f"Processing translation to {target_language}...")

    system_instruction = f"""
    You are a Senior Technical Translator specialized in Software Engineering and AI.
    Your task is to translate technical articles to {target_language}.

    QUALITY GUIDELINES:
    1. Terminology: Keep industry standards term in English (e.g., 'deploy', 'pipeline', 'framework', 'commit', 'edge computing').
    2. Code Integraty: NEVER translate code snippets, function names, or variable names
    3. Format: Output strictly in Markdown.

    """

    message = [
        ("system", system_instruction),
        ("user", text)
    ]

    try:
        response = llm.invoke(messages)
        return response.content
    except Exception as e:
        print(f"Error during translation: {e}")
        return None
    
#CLI Execution
if __name__ == "__main__":
    print("---OT/IT Technical Translator ---")
    print("Enter the text to translate (Press Ctrl+D or Ctrl+Z to finish input):")

    # Read multi-line input
    input_text = sys.stdin.read()

    if not input_text.strip():
        print("No text provided.")
        sys.exit(0)

    target_lang = "Portuguese (Brazil)" # Default for this version

    result = translate_article(input_text, target_lang)

    if result:
        print("\n--- Translation Result ---\n")
        print(result)
        print("\n----------------------------")



    


