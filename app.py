from flask import Flask
from flask import render_template
from flask import request


app = Flask(__name__)
@app.route('/')
def home():
    return render_template('index.html')
@app.route('/pedidos')
def pedido():
    return render_template('pedido.html')


@app.route('/realizar_pedido', methods=['POST'])
def realizar_pedido():
    metodo_pagamento = request.form['pagamento']  # Obtém o método de pagamento selecionado
    
    # Redireciona com base no método de pagamento escolhido
    if metodo_pagamento == 'cartao':
        return render_template('pagamento_cartao')
    elif metodo_pagamento == 'pix':
        return render_template('pagamento_pix')
    elif metodo_pagamento == 'dinheiro':
        return render_template('pagamento_dinheiro')

@app.route('/pagamento/cartao')
def pagamento_cartao():
    return "Página de pagamento com Cartão"

@app.route('/pagamento/pix')
def pagamento_pix():
    return "Página de pagamento via Pix"

@app.route('/pagamento/dinheiro')
def pagamento_dinheiro():
    return "Página de pagamento em Dinheiro"
