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
import os
from werkzeug.utils import secure_filename

import json


data_hora_atual = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

app = Flask(__name__)

@app.route('/')
def finalizacaoPedido():
    try:
        with open('database-professor/ifood.conf', 'r') as dadosbd: 
            databd = json.load(dadosbd)

        cnx = connection.MySQLConnection(user=databd['user'],
                                    password=databd['pass'],
                                    host=databd['host'],
                                    database=databd['database'])
        cursor=cnx.cursor()
        querry="select id, nome, preco, imagem from produto"
        cursor.execute(querry,)

        resul=cursor.fetchall()
        cursor.close()
    
        return render_template('restaurantes copy.html', restaurante=resul)
    
    except Exception as e:
        print (f"FALHA NA CONEXÃO COM O BANCO: {e}")
    

@app.route('/adicionando_carrinho', methods=['POST'])
def  carrinho():
    produto_id = request.form['produto_id']

    try:
        with open('database-professor/ifood.conf', 'r') as dadosbd: 
            databd = json.load(dadosbd)

        cnx = connection.MySQLConnection(user=databd['user'],
                                    password=databd['pass'],
                                    host=databd['host'],
                                    database=databd['database'])
        cursor=cnx.cursor()
        querry="select id, nome, preco, imagem from produto where id=%s"
        cursor.execute(querry,(produto_id,))

        resul=cursor.fetchall()
        cursor.close()
        return render_template('compras2.html', carrinho=resul)

    except Exception as e:
        print (f"FALHA NA CONEXÃO COM O BANCO: {e}")
  
@app.route('/adicionar_ao_carrinho', methods=['POST'])
def adicionar_ao_carrinho():
    data = request.get_json()
    
    produtos = data['produtos']

    # Conecta ao banco de dados
    

    # Itera sobre os produtos e insere no banco
    for produto in produtos:
        idProduto = produto['id']

        preco = produto['preco']
        quantidade = produto['quantidade']

        # Consulta SQL para inserir no banco de dados
    status = createUpdateDelete(
                "insert into relacContem  idProduto = %s, preco = %s, quantidade=%s WHERE idPedido = 1",
                (idProduto, preco, quantidade,),
                'UPDATE'
            ) #alteracao 4 
    return

    # Commit para garantir que os dados foram salvos
  


@app.route('/finalizar_pedido', methods=['POST'])
def adicionandoPedidoBD():
        id = request.form['id']
        endereco = request.form['endereco']
        tipoPagamento = request.form['pagamento']

        
        status = createUpdateDelete(
            "INSERT INTO pedido (id,localidade,taxaEntrega, statusPedido, tipoPagamento, dataHora, statusPagamento, idUsuarioPede) VALUES (%s, %s, 0.0, 'Aguardando Aprovação',  %s, %s, 'Pendente', 1)",
            (id,endereco, tipoPagamento, data_hora_atual),
            'INSERT'
        )

       
        if tipoPagamento == 'pix':
          return render_template('pix.html')
      
        
        else:
            return render_template('resposta.html')
        
####################################################################################
@app.route('/finalizar_compra', methods=['POST'])
def finalizar_compra():
    data = request.get_json()

    # Coletando os dados do corpo da requisição
    cpf = data['cpf']
    endereco = data['endereco']
    metodo_pagamento = data['metodoPagamento']
    produtos = data['produtos']
  
    # Inserir dados do pedido na tabela 'pedido'
    status = createUpdateDelete(
            "INSERT INTO pedido (id,localidade,taxaEntrega, statusPedido, tipoPagamento, dataHora, statusPagamento, idUsuarioPede) VALUES (%s, %s, 0.0, 'Aguardando Aprovação',  %s, %s, 'Pendente', 1)",
            (cpf,endereco, metodo_pagamento, data_hora_atual),
            'INSERT'
        )

    # Pegar o ID do pedido recém-criado

    # Inserir itens no pedido na tabela 'item_pedido'
    for produto in produtos:
        id_produto = produto['idProduto']  # Agora estamos pegando o idProduto
        nome = produto['nome']
        preco = produto['preco']
        quantidade = produto['quantidade']
        total = produto['total']

    status = createUpdateDelete(
            "INSERT INTO relacContem (idProduto, idPedido,preco, quantidade) VALUES (%s, %s, %s, %s)",
            (id_produto,cpf, preco, quantidade),
            'INSERT'
        )
    
    return 'deu certo'

#para a url das imagens salvas no banco aparecerem quando o produto for adicionado ao carrinho

# Diretório onde as imagens serão salvas
UPLOAD_FOLDER = '/img'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

# Função para verificar se o arquivo tem extensão permitida
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

with open('database-professor/ifood.conf', 'r') as dadosbd: 
            databd = json.load(dadosbd)

cnx = connection.MySQLConnection(user=databd['user'],
                                    password=databd['pass'],
                                    host=databd['host'],
                                    database=databd['database'])

# Rota para upload da imagem
@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return "Nenhum arquivo enviado", 400

    file = request.files['file']
    
    if file.filename == '':
        return "Arquivo sem nome", 400
    
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(filepath)

        # Guardando o caminho no banco de dados
        cursor = cnx.cursor()
        sql = "INSERT INTO produto (nome, preco, imagem, idCategoria, idRestaurante) VALUES (%s, %s, %s, %s, %s)"
        valores = ("Nome do Produto", 25.00, f"img/{filename}", 1, 1)
        cursor.execute(sql, valores)
        cnx.commit()
        cursor.close()

        return "Imagem enviada com sucesso!"

    return "Arquivo não permitido", 400

if __name__ == '__main__':
    app.run(debug=True)

@app.route('/produtos')
def listar_produtos():
    cursor = db.cursor()
    cursor.execute("SELECT id, nome, preco, imagem FROM produto")
    produtos = cursor.fetchall()
    cursor.close()
    
    return render_template('produtos.html', produtos=produtos)
