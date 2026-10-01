from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def home():
    return "My DevOps application is running"


@app.route("/health")
def health():
    return jsonify({"status": "healthy"})


app.run(host="0.0.0.0", port=8000)
