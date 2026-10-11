import os
from flask import Flask, render_template, jsonify
app=Flask(__name__)
@app.route("/")
def home(): return render_template("index.html", birthday_date=os.environ.get("SONALI_BIRTH_DATE", "").strip(), birthday_time=os.environ.get("SONALI_BIRTH_TIME", "00:00"))
@app.route("/health")
def health(): return jsonify({"status":"ok","site":"SONALI Birthday Gift"})
@app.errorhandler(404)
def missing(_): return render_template("error.html", code=404, message="This page could not be found."),404
if __name__ == "__main__": app.run(host="127.0.0.1",port=int(os.environ.get("PORT","5000")),debug=False)
