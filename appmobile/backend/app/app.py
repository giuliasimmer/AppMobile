from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error

def create_app():
    app = Flask(__name__)
    CORS(app)  # Isso permitirá CORS para todas as rotas

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
            try:
                cursor = connection.cursor()
                query = 'INSERT INTO EscolhaCurvatura (LISO, ONDULADO, CACHEADO) VALUES (%s, %s, %s)'
                cursor.execute(query, (liso, ondulado, cacheado))
                connection.commit()
                return jsonify({"message": "Dados inseridos com sucesso"}), 200
            except Error as e:
                print(f"Erro ao inserir dados: {e}")
                return jsonify({"message": "Erro ao inserir dados"}), 500
            finally:
                cursor.close()
                connection.close()
        return jsonify({"message": "Erro ao conectar ao banco de dados"}), 500

    @app.route('/buscacurvatura', methods=['GET'])
    def get_escolha_curvatura():
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                query = 'SELECT * FROM EscolhaCurvatura'
                cursor.execute(query)
                records = cursor.fetchall()
                return jsonify(records), 200
            except Error as e:
                print(f"Erro ao buscar dados: {e}")
                return jsonify({"message": "Erro ao buscar dados"}), 500
            finally:
                cursor.close()
                connection.close()
        return jsonify({"message": "Erro ao conectar ao banco de dados"}), 500

    @app.route('/escolhatipo', methods=['POST'])
    def escolha_tipo():
        data = request.json
        oleoso = data.get('oleoso', 0)
        normal = data.get('normal', 0)
        seco = data.get('seco', 0)
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                query = 'INSERT INTO TipoCabelo (OLEOSO, NORMAL, SECO) VALUES (%s, %s, %s)'
                cursor.execute(query, (oleoso, normal, seco))
                connection.commit()
                return jsonify({"message": "Dados inseridos com sucesso"}), 200
            except Error as e:
                print(f"Erro ao inserir dados: {e}")
                return jsonify({"message": "Erro ao inserir dados"}), 500
            finally:
                cursor.close()
                connection.close()
        return jsonify({"message": "Erro ao conectar ao banco de dados"}), 500

    @app.route('/buscatipocabelo', methods=['GET'])
    def get_escolha_tipo():
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                query = 'SELECT * FROM TipoCabelo'
                cursor.execute(query)
                records = cursor.fetchall()
                return jsonify(records), 200
            except Error as e:
                print(f"Erro ao buscar dados: {e}")
                return jsonify({"message": "Erro ao buscar dados"}), 500
            finally:
                cursor.close()
                connection.close()
        return jsonify({"message": "Erro ao conectar ao banco de dados"}), 500

    return app
