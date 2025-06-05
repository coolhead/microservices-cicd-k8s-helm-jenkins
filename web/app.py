from flask import Flask
import requests
app = Flask(__name__)

@app.route('/')
def index():
    r = requests.get("http://auth/health")
    return f"Web frontend working. Auth says: {r.text}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

