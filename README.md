# urca (User Request based Capital market Analyzer)
Stock Analysis using AI

## Objective
Building an AI-driven solution for stock analysis. The solution uses open source AI Groq for NLP and data processing. The code was designed to:
1.	Fetch stock prices using a free API (Twelve Data).
2.	Process user instructions with Groq for natural language understanding.
3.	Calculate and rank stock returns based on industry standards.
4.	Deploy the solution on AWS in a serverless architecture, accessible via API.

## HLD
<img width="643" alt="image" src="https://github.com/user-attachments/assets/01c0af55-5366-4d02-a332-6c3f4b6a92e4" />

## LLD
<img width="703" alt="image" src="https://github.com/user-attachments/assets/d37ab0d1-741b-4cc8-8db2-b625c6ee2a4d" />

## Future Scope
<img width="703" alt="image" src="https://github.com/user-attachments/assets/ebd1a8d0-fa00-4da8-864b-e872915d7b0d" />

## pre requisities:

Python 3.12
Dependencies:
--Pandas
--requests
--flask
Terraform

## request format:
{
  "user_input": "Do the analysis of the stocks for last 3 months Reliance, ONGC, Oil India, Indian Oil and HPC from NSE data and then let me know the rank wise stock performance based on their weekly return"
}

## response format :
{
    "data": {
        "analysis": {
            "exchange": "NSE",
            "metric": "weekly return",
            "period": "last 3 months",
            "stocks": [
                "Reliance",
                "ONGC",
                "Oil India",
                "Indian Oil",
                "HPC"
            ]
        },
        "results": {
            "rank_wise_performance": [
                {
                    "rank": 1,
                    "stock": "Reliance",
                    "weekly_return": 4.25
                },
                {
                    "rank": 2,
                    "stock": "HPC",
                    "weekly_return": 4.01
                },
                {
                    "rank": 3,
                    "stock": "Oil India",
                    "weekly_return": 3.52
                },
                {
                    "rank": 4,
                    "stock": "ONGC",
                    "weekly_return": 3.15
                },
                {
                    "rank": 5,
                    "stock": "Indian Oil",
                    "weekly_return": 2.81
                }
            ],
            "weekly_return": {
                "HPC": 4.01,
                "Indian Oil": 2.81,
                "ONGC": 3.15,
                "Oil India": 3.52,
                "Reliance": 4.25
            }
        },
        "summary": "Based on the analysis of the last 3 months of NSE data, the rank wise stock performance is led by Reliance with a weekly return of 4.25, followed by HPC with a weekly return of 4.01. Oil India, ONGC, and Indian Oil have weekly returns of 3.52, 3.15, and 2.81 respectively."
    },
    "response": "success"
}
