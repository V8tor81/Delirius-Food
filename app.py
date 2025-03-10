from flask import Flask
from flask import render_template
from flask import request
from crud import createUpdateDelete
from flask import session
from crud import read
from datetime import datetime
from mysql.connector import (connection)
from crud import conexaoBD
from flask import Flask, request, redirect, url_for, render_template

import json


data_hora_atual = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

app = Flask(__name__)

@app.route('/')
def paginaProdutos():
    try:
        with open('Banco povoado/ifoodPovoado.conf', 'r') as dadosbd: 
            databd = json.load(dadosbd)

        cnx = connection.MySQLConnection(user=databd['user'],
                                    password=databd['pass'],
                                    host=databd['host'],
                                    database=databd['database'])
        cursor=cnx.cursor()
        querry="select id, nome, preco, imagem, descricao, tempoPreparo from produto"
        cursor.execute(querry,)

        resul=cursor.fetchall()
        cursor.close()
    
        return render_template('restaurantes.html', restaurante=resul)
    
    except Exception as e:
        print (f"FALHA NA CONEXÃO COM O BANCO: {e}")
    

@app.route('/adicionando_carrinho', methods=['POST'])
def carrinho():
    produto_id = request.form['produto_id']

    try:
        with open('Banco povoado/ifoodPovoado.conf', 'r') as dadosbd: 
            databd = json.load(dadosbd)

        cnx = connection.MySQLConnection(user=databd['user'],
                                         password=databd['pass'],
                                         host=databd['host'],
                                         database=databd['database'])
        cursor = cnx.cursor()
        query = "select id, nome, preco, imagem from produto where id=%s"
        cursor.execute(query, (produto_id,))
        
        result = cursor.fetchall()
        cursor.close()

        return render_template('compras.html', carrinho=result)

    except Exception as e:
        print(f"FALHA NA CONEXÃO COM O BANCO: {e}")
        
       
        return 'erro'


@app.route('/finalizacao_pedido', methods=['POST'])
def adicionandoPedidoBD():
        
        id_pedido = request.form['id_pedido']
        id_produto=request.form['id_produto']
        endereco = request.form['endereco']
        tipoPagamento = request.form['metodo-pagamento']
        preco=float(request.form['preco'])
        quantidade=int(request.form['quantidade'])
        total=preco*quantidade

        
        status = createUpdateDelete(
            "INSERT INTO pedido (id,localidade,taxaEntrega, statusPedido, tipoPagamento, dataHora, statusPagamento, idUsuarioPede) VALUES (%s, %s, 0.0, 'Em preparo',  %s, %s, 'Pendente', 1)",
            (id_pedido,endereco, tipoPagamento, data_hora_atual),
            'INSERT'
        )

        status = createUpdateDelete(
            "INSERT INTO relacContem (idProduto, idPedido, preco, quantidade) VALUES (%s, %s, %s, %s)",
            (id_produto,id_pedido, preco, quantidade),
            'INSERT'
        )

       
        if tipoPagamento == 'pix':
          return render_template('pix.html', valor=total)
      
        
        else:
            return render_template('resposta.html', valor=total)


@app.route('/home')
def home():
    return render_template('home.html')  #página inicial

@app.route('/login')
def login():
    return render_template('login.html')  #página login

@app.route('/cadastro')
def cadastro():
    return render_template('cadastro.html') #página cadastro

@app.route('/restaurantes')
def restaurantes():
    return render_template('restaurantes.html')  #página restaurantes

@app.route('/compras')
def compras():
    return render_template('compras.html')  #página compras

@app.route('/cadastroDono')
def cadastroDono():
    return render_template('cadastroDono.html') 

@app.route('/pedidos')
def pedidos():
    return render_template('pedidos.html')

@app.route('/relatorio')
def relatorio():
    return render_template('relatorio.html')

@app.route('/visaoDono')
def visaoDono():
    return render_template('visaoDono.html')

if __name__ == '__main__':
    app.run(debug=True)