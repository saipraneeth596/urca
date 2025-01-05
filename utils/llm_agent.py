import requests
import logging

class LLM_Agent:
    def __init__(self):
        self.api_url = "https://api.groq.com/openai/v1/chat/completions"
        self.api_key = "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"

    def parse_instruction(self, instruction):
        headers = {
            "Content-Type": "application/json",
            "Authorization": f"Bearer {self.api_key}"
        }
        payload = {
            "model": "llama-3.3-70b-versatile",
            "messages": [
                {
                    "role": "system",
                    "content": "You are a data analyst API capable of parsing stock analysis instructions and responding in JSON."
                },
                {
                    "role": "user",
                    "content": f"Parse the following instruction: {instruction}"
                }
            ],
            "response_format": {"type": "json_object"}
        }
        response = requests.post(self.api_url, headers=headers, json=payload)
        return self._handle_response(response)

    def _handle_response(self, response):
        try:
            response.raise_for_status()
            response_data = response.json()
            logging.info(f"Response Data: {response_data}")
            if "choices" in response_data:
                return response_data["choices"][0]["message"]["content"]
            else:
                raise ValueError(f"Unexpected response format: {response_data}")
        except requests.exceptions.RequestException as err:
            logging.error(f"Request error occurred: {err}")
            raise ValueError(f"Request error occurred: {err}")
