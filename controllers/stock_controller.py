from flask import Flask, request, jsonify
from services.stock_service import analyze_stocks

app = Flask(__name__)

@app.route('/analyze', methods=['POST'])
def analyze():
    data = request.json
    print("Received data:", data)  # Debug print
    user_input = data.get('user_input')
    if not user_input:
        return jsonify({'error': 'User input is required'}), 400
    try:
        result = analyze_stocks(user_input)
        return jsonify(result)
    except Exception as e:
        print("Error occurred:", str(e))  # Debug print
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
