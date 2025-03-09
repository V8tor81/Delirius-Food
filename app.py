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
    
        return render_template('restaurantes2.html', restaurante=resul)
    
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

        return render_template('compras2.html', carrinho=result)

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
        

  
@app.route('/voltar', methods=['GET'])
def retornar():
    return render_template('compras2.html')


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
