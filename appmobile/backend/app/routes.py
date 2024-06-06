from flask import Blueprint, jsonify # type: ignore
from app.models import get_db_connection

main = Blueprint('main', __name__)

@main.route('/products', methods=['GET'])
def get_products():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT * FROM consulta')
    products = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(products)
