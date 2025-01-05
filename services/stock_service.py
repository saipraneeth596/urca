from utils.stock_utils import fetch_and_analyze_stock_data
import logging

def analyze_stocks(user_input):
    groq_api_key = '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'
    
    try:
        logging.info(f"Received user input: {user_input}")  # Debug print
        performance = fetch_and_analyze_stock_data(user_input, groq_api_key)
        logging.info(f"Performance data: {performance}")  # Debug print
        if not performance:
            raise ValueError('Could not extract necessary parameters from user input.')
    except Exception as e:
        logging.error(f"Error in fetch_and_analyze_stock_data: {str(e)}")  # Debug print
        raise

    return {'response': 'success', 'data': performance}
