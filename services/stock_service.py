import pandas as pd
import numpy as np
from datetime import datetime, timedelta
from utils.stock_utils import fetch_and_analyze_stock_data

def analyze_stocks(user_input):
    groq_api_key = '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'
    
    try:
        performance = fetch_and_analyze_stock_data(user_input, groq_api_key)
        if not performance:
            raise ValueError('Could not extract necessary parameters from user input.')
    except Exception as e:
        print("Error in fetch_and_analyze_stock_data:", str(e))  # Debug print
        raise

    return {'response': 'success', 'data': performance}
