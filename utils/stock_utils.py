import re
import requests
import logging
import json  # Add this import
from utils.llm_agent import LLM_Agent

# Groq API interaction for fetching stock data and performing analysis
def fetch_and_analyze_stock_data(user_input, groq_api_key):
    agent = LLM_Agent()
    content = agent.parse_instruction(user_input)
    logging.info(f"Groq response content: {content}")  # Debug print
    print(f"Groq response content: {content}")  # Print for manual inspection
    return parse_groq_response(content)

def parse_groq_response(content):
    # Strip backticks and parse JSON
    try:
        content = content.strip('```json').strip('```')
        response_data = json.loads(content)
        return response_data  # Return the entire response content
    except json.JSONDecodeError as e:
        logging.error(f"JSON decode error: {e}")
        raise ValueError("Invalid JSON format in response")
