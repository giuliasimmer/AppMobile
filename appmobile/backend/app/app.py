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
        seco = data.get('seco', 0)
        normal = data.get('normal', 0)
        oleoso = data.get('oleoso', 0)
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                query = 'INSERT INTO TipoCabelo (SECO, NORMAL, OLEOSO) VALUES (%s, %s, %s)'
                cursor.execute(query, (seco, normal, oleoso))
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

    @app.route('/recolhecabelo', methods=['POST'])
    def recolhe_cabelo():
        data = request.get_json()
        curvatura = data.get('curvatura')
        tipo_cabelo = data.get('tipo_cabelo')

        # Determinando o nome da tabela de resultados
        result_table_name = None
        if curvatura == 'LISO':
            if tipo_cabelo == 'SECO':
                result_table_name = 'LISO_SECO'
            elif tipo_cabelo == 'NORMAL':
                result_table_name = 'LISO_NORMAL'
            elif tipo_cabelo == 'OLEOSO':
                result_table_name = 'LISO_OLEOSO'
        elif curvatura == 'ONDULADO':
            if tipo_cabelo == 'SECO':
                result_table_name = 'ONDULADO_SECO'
            elif tipo_cabelo == 'NORMAL':
                result_table_name = 'ONDULADO_NORMAL'
            elif tipo_cabelo == 'OLEOSO':
                result_table_name = 'ONDULADO_OLEOSO'
        elif curvatura == 'CACHEADO':
            if tipo_cabelo == 'SECO':
                result_table_name = 'CACHEADO_SECO'
            elif tipo_cabelo == 'NORMAL':
                result_table_name = 'CACHEADO_NORMAL'
            elif tipo_cabelo == 'OLEOSO':
                result_table_name = 'CACHEADO_OLEOSO'

        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                if result_table_name:
                    # Inserindo na tabela ResultadoGetCabelo
                    cursor.execute(
                        "INSERT INTO ResultadoGetCabelo (id, curvatura, tipo_cabelo, result_table_name) VALUES (%s, %s, %s, %s)",
                        (0, curvatura, tipo_cabelo, result_table_name)
                    )
                    connection.commit()

                    # Retornando o nome da tabela
                    return jsonify({"result_table_name": result_table_name})
                else:
                    return jsonify({"error": "Invalid combination"}), 400
            except mysql.connector.Error as err:
                return jsonify({"error": str(err)}), 500
            finally:
                cursor.close()
                connection.close()
        else:
            return jsonify({"error": "Erro ao conectar ao banco de dados"}), 500

    @app.route('/resultadocabelo', methods=['GET'])
    def get_resultado_cabelo():
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                query = 'SELECT result_table_name FROM ResultadoGetCabelo ORDER BY id DESC LIMIT 1'
                cursor.execute(query)
                record = cursor.fetchone()

                if record:
                    result_table_name = record[0]
                    query_data = f'SELECT * FROM {result_table_name}'
                    cursor.execute(query_data)
                    data = cursor.fetchall()

                    columns = [desc[0] for desc in cursor.description]
                    result_data = [dict(zip(columns, row)) for row in data]

                    return jsonify({result_table_name: result_data}), 200
                else:
                    return jsonify({"message": "Nenhum dado encontrado"}), 404
            except Error as e:
                print(f"Erro ao buscar dados: {e}")
                return jsonify({"message": "Erro ao buscar dados"}), 500
            finally:
                cursor.close()
                connection.close()
        else:
            return jsonify({"message": "Erro ao conectar ao banco de dados"}), 500

        
    return app

if __name__ == '__main__':
    app = create_app()
    app.run(debug=True)
