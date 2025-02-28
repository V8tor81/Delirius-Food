from mysql.connector import (connection)


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
    