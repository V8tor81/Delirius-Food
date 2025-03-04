from mysql.connector import (connection)

import json

def conexaoBD():
    try:
        with open('database-professor/ifood.conf') as dadosbd: 
            databd = json.load(dadosbd)

        cnx = connection.MySQLConnection(user=databd['user'],
                                    password=databd['pass'],
                                    host=databd['host'],
                                    database=databd['database'])
        
        return cnx
    
    except Exception as e:
        print (f"FALHA NA CONEXÃO COM O BANCO: {e}")
    
def createUpdateDelete(sql:str, tupla:tuple, tipo:str):
    try:
        with open('database-professor/ifood.conf') as dadosbd: 
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



