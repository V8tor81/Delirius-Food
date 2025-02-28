from flask import Flask
from flask import render_template
from flask import request


app = Flask(__name__)

@app.route('/pedidos')
def home():
    return render_template('home.html')