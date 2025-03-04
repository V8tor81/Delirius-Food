from flask import Flask
from flask import render_template
from flask import request
from crud import createUpdateDelete

from datetime import datetime

data_hora_atual = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

app = Flask(__name__)

@app.route('/')
def finalizacaoPedido():
    return render_template('finalizacaoPedido.html')


@app.route('/finalizar_pedido', methods=['POST'])
def adicionandoPedidoBD():
        id = request.form['id']
        endereco = request.form['endereco']
        tipoPagamento = request.form['pagamento']

        
        status = createUpdateDelete(
            "INSERT INTO pedido (id,localidade,taxaEntrega, statusPedido, tipoPagamento, dataHora, statusPagamento, idUsuarioPede) VALUES (%s, %s, 5.2, 'Aguardando Aprovação',  %s, %s, 'Pendente', 1)",
            (id,endereco, tipoPagamento, data_hora_atual),
            'INSERT'
        )

       
        if tipoPagamento == 'pix':
          return render_template('pix.html')
      
        
        else:
            return render_template('resposta.html')
        
