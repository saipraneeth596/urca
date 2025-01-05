import re
import requests
import logging

# Groq API interaction for fetching stock data and performing analysis
def fetch_and_analyze_stock_data(user_input, groq_api_key):
    headers = {
        'Authorization': f'Bearer {groq_api_key}',
        'Content-Type': 'application/json'
    }
    data = {
        'model': 'llama-3.3-70b-versatile',
        'messages': [{'role': 'user', 'content': user_input}]
    }
    response = requests.post('https://api.groq.com/openai/v1/chat/completions', headers=headers, json=data)
    response.raise_for_status()
    result = response.json()
    content = result['choices'][0]['message']['content']
    logging.info(f"Groq response content: {content}")  # Debug print
    return parse_groq_response(content)

def parse_groq_response(content):
    # Extract rank-wise performance from Groq's response
    rank_pattern = re.compile(r'(\d+)\.\s\*\*(.*?)\*\*.*?average weekly return of ([\d.]+)')
    matches = rank_pattern.findall(content)
    logging.info(f"Parsed matches: {matches}")  # Debug print
    performance = [{'rank': int(match[0]), 'stock_name': match[1], 'average_return': float(match[2])} for match in matches]
    return performance
