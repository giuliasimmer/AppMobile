from flask import Flask, request, jsonify
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

def create_connection():
    connection = None
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='admin',
            database='appmobile'
        )
        if connection.is_connected():
            print('Conectado ao banco de dados MySQL')
    except Error as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
    return connection

@app.route('/escolhacurvatura', methods=['POST'])
def escolha_curvatura():
    data = request.json
    liso = data.get('liso', 0)
    ondulado = data.get('ondulado', 0)
    cacheado = data.get('cacheado', 0)
    connection = create_connection()
    if connection:
        cursor = connection.cursor()
        query = 'INSERT INTO EscolhaCurvatura (LISO, ONDULADO, CACHEADO) VALUES (%s, %s, %s)'
        cursor.execute(query, (liso, ondulado, cacheado))
        connection.commit()
        cursor.close()
        connection.close()
        return jsonify({"message": "Dados inseridos com sucesso"}), 200
    return jsonify({"message": "Erro ao conectar ao banco de dados"}), 500

@app.route('/buscacurvatura', methods=['GET'])
def get_escolha_curvatura():
    connection = create_connection()
    if connection:
        cursor = connection.cursor(dictionary=True)
        query = 'SELECT * FROM EscolhaCurvatura'
        cursor.execute(query)
        records = cursor.fetchall()
        cursor.close()
        connection.close()
        return jsonify(records), 200
    return jsonify({"message": "Erro ao conectar ao banco de dados"}), 500

@app.route('/escolhatipo', methods=['POST'])
def escolha_tipo():
    data = request.json
    oleoso = data.get('oleoso', 0)
    normal = data.get('normal', 0)
    seco = data.get('seco', 0)
    connection = create_connection()
    if connection:
        cursor = connection.cursor()
        query = 'INSERT INTO TipoCabelo(OLEOSO, NORMAL, SECO) VALUES (%s, %s, %s)'
        cursor.execute(query, (oleoso, normal, seco))
        connection.commit()
        cursor.close()
        connection.close()
        return jsonify({"message": "Dados inseridos com sucesso"}), 200
    return jsonify({"message": "Erro ao conectar ao banco de dados"}), 500

@app.route('/buscatipocabelo', methods=['GET'])
def get_escolha_tipo():
    connection = create_connection()
    if connection:
        cursor = connection.cursor(dictionary=True)
        query = 'SELECT * FROM TipoCabelo'
        cursor.execute(query)
        records = cursor.fetchall()
        cursor.close()
        connection.close()
        return jsonify(records), 200
    return jsonify({"message": "Erro ao conectar ao banco de dados"}), 500

if __name__ == '__main__':
    app.run(debug=True)
