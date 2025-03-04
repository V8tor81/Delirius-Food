from mysql.connector import (connection)

import json



'''
####################################################################
# Código Python para interação com o banco de dados
####################################################################
'''
# Desc: Conexão com o banco de dados a partir da leitura do arquivo database/clinica.conf
# Entrada: None
# Saída: Conexão do banco de dados
def conexaoBD():
    try:
        with open('database-professor/ifood.conf', 'r') as dadosbd: 
            databd = json.load(dadosbd)

        cnx = connection.MySQLConnection(user=databd['user'],
                                    password=databd['pass'],
                                    host=databd['host'],
                                    database=databd['database'])
        
        return cnx
    
    except Exception as e:
        print (f"FALHA NA CONEXÃO COM O BANCO: {e}")
    
    


# Desc: Função responsável pelas transações de inserção, atualização e remoção no banco de dados
# Entrada:  1 - STRING com o comando SQL desejado;
#           2 - Tupla com os dados
#           3 - String informando qual o tipo de comando, se INSERT, UPDATE ou DELETE
# Saída: True se tudo ocorreu bem | False se houve alguma falha
def createUpdateDelete(sql:str, tupla:tuple, tipo:str):
    try:
        with open('database-professor/ifood.conf', 'r') as dadosbd: 
            databd = json.load(dadosbd)

        cnx = connection.MySQLConnection(user=databd['user'],
                                    password=databd['pass'],
                                    host=databd['host'],
                                    database=databd['database'])

        cursor = cnx.cursor()

        if tipo == "INSERT":
            cursor.execute(sql, tupla)
        elif tipo == "UPDATE":
            cursor.execute(sql, tupla)
        elif tipo == "DELETE":
            cursor.execute(sql, tupla)
        
        cnx.commit()

        return True

    except Exception as e:
        print (f"FALHA NO {tipo} NO BANCO: {e}")
        return False



