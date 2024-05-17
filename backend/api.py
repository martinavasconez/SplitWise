from flask import Flask, jsonify, request
from db import connect_to_mysql
import db_config
app = Flask(__name__)

# Database connection details
HOST = db_config.HOST
USER = db_config.USER
PORT = db_config.PORT
PASSWORD = db_config.PASSWORD
DATABASE = db_config.DATABASE



@app.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()
    nombre = data['nombre']
    correo = data['correo']
    password = data['password']

    connection = connect_to_mysql(db_config.HOST, db_config.USER, db_config.PASSWORD, db_config.DATABASE, db_config.PORT)
    cursor = connection.cursor()

    query = "INSERT INTO Usuarios (nombre, correo, password) VALUES (%s, %s, %s)"
    cursor.execute(query, (nombre, correo, password))

    query = "SELECT * FROM Usuarios WHERE correo=%s AND password=%s"
    cursor.execute(query, (correo, password))

    user = [{"id": row[0], "nombre": row[1], "correo": row[2]} for row in cursor.fetchall()][0]
    connection.commit()

    response = {"message": "User created successfully", "user": user}
    return jsonify(response), 201

@app.route('/signin', methods=['POST'])
def signin():
    data = request.get_json()
    correo = data['correo']
    password = data['password']

    connection = connect_to_mysql(db_config.HOST, db_config.USER, db_config.PASSWORD, db_config.DATABASE, db_config.PORT)
    cursor = connection.cursor()

    query = "SELECT * FROM Usuarios WHERE correo=%s AND password=%s"
    cursor.execute(query, (correo, password))

    user = [{"id": row[0], "nombre": row[1], "correo": row[2]} for row in cursor.fetchall()][0]

    if user:
        return jsonify({"message": "Logged in successfully", "user": user}), 200
    else:
        return jsonify({"message": "Invalid credentials"}), 401

@app.route('/groups/<int:user_id>', methods=['GET'])
def fetch_groups(user_id):
    connection = connect_to_mysql(db_config.HOST, db_config.USER, db_config.PASSWORD, db_config.DATABASE, db_config.PORT)
    cursor = connection.cursor()

    query = "SELECT * FROM Grupos INNER JOIN Usuario_Grupo ON Grupos.id = Usuario_Grupo.grupo_id WHERE Usuario_Grupo.usuario_id = %s"
    cursor.execute(query, (user_id,))

    groups = [{"id": row[0], "nombre": row[1], "detalles": row[2], "total": row[3]} for row in cursor.fetchall()]
    return jsonify(groups), 200


@app.route('/create_group', methods=['POST'])
def create_group():
    data = request.get_json()
    nombre = data['nombre']
    detalles = data['detalles']
    user_id = data['user_id']

    connection = connect_to_mysql(db_config.HOST, db_config.USER, db_config.PASSWORD, db_config.DATABASE, db_config.PORT)
    cursor = connection.cursor()

    query = "INSERT INTO Grupos (nombre, detalles) VALUES (%s, %s)"
    cursor.execute(query, (nombre, detalles))
    group_id = cursor.lastrowid

    query = "INSERT INTO Usuario_Grupo (usuario_id, grupo_id) VALUES (%s, %s)"
    cursor.execute(query, (user_id, group_id))

    connection.commit()

    return jsonify({"message": "Group created successfully", "group": {"id": group_id, "nombre": nombre, "detalles": detalles, "total":0}}), 201

@app.route('/join_group/<int:group_id>', methods=['POST'])
def join_group(group_id):
    data = request.get_json()
    user_id = data['user_id']

    connection = connect_to_mysql(db_config.HOST, db_config.USER, db_config.PASSWORD, db_config.DATABASE, db_config.PORT)
    cursor = connection.cursor()

    query = "INSERT INTO Usuario_Grupo (usuario_id, grupo_id) VALUES (%s, %s)"
    cursor.execute(query, (user_id, group_id))

    query = "SELECT * FROM Grupos WHERE id=%s"
    cursor.execute(query, (group_id,))
    group = [{"id": row[0], "nombre": row[1], "detalles": row[2], "total": row[3]} for row in cursor.fetchall()]
    print(group)

    connection.commit()

    return jsonify({"message": "Joined group successfully", "group": group[0]}), 200

@app.route('/edit_details/<int:group_id>', methods=['PUT'])
def edit_details(group_id):
    data = request.get_json()
    detalles = data['detalles']

    connection = connect_to_mysql(db_config.HOST, db_config.USER, db_config.PASSWORD, db_config.DATABASE, db_config.PORT)
    cursor = connection.cursor()

    query = "UPDATE Grupos SET detalles = %s WHERE id = %s"
    cursor.execute(query, (detalles, group_id))

    query = "SELECT * FROM Grupos WHERE id=%s"
    cursor.execute(query, (group_id,))
    group = [{"id": row[0], "nombre": row[1], "detalles": row[2], "total": row[3]} for row in cursor.fetchall()]

    connection.commit()

    return jsonify({"message": "Details updated successfully", "group": group[0]}), 200

@app.route('/delete_group/<int:group_id>', methods=['DELETE'])
def delete_group(group_id):
    connection = connect_to_mysql(db_config.HOST, db_config.USER, db_config.PASSWORD, db_config.DATABASE, db_config.PORT)
    cursor = connection.cursor()

    query = "DELETE FROM Grupos WHERE id = %s"
    cursor.execute(query, (group_id,))

    connection.commit()

    return jsonify({"message": "Group deleted successfully"}), 200

@app.route('/add_item', methods=['POST'])
def add_item():
    data = request.get_json()
    grupo_id = data['grupo_id']
    user_id = data['user_id']
    nombre_articulo = data['nombre_articulo']
    costo = data['costo']

    connection = connect_to_mysql(db_config.HOST, db_config.USER, db_config.PASSWORD, db_config.DATABASE, db_config.PORT)
    cursor = connection.cursor()

    query = "INSERT INTO Articulos (grupo_id, usuario_id, nombre_articulo, costo) VALUES (%s, %s, %s, %s)"
    cursor.execute(query, (grupo_id, user_id, nombre_articulo, costo))

    connection.commit()

    return jsonify({"message": "Item added successfully", "item": {"id": cursor.lastrowid, "nombre_articulo": nombre_articulo, "costo": costo}}), 201


def calculate_payments(input_json):
    # Calculate average total
    totals = [float(user["total"]) for user in input_json["totalPorUsuario"]]
    average_total = sum(totals) / len(totals)

    # Calculate debts
    debts = []
    for user in input_json["totalPorUsuario"]:
        id_usuario = user["id_usuario"]
        total = float(user["total"])
        deuda = round(total - average_total, 2)
        debts.append({
            "id_usuario": id_usuario,
            "deuda": deuda
        })

    # Separate into two lists: those who need to pay and those who need to be paid
    paying_users = [user for user in debts if user["deuda"] < 0]
    receiving_users = [user for user in debts if user["deuda"] > 0]

    # Initialize the result structure
    payments = {}

    # Use stacks to manage the debts
    while paying_users and receiving_users:
        payer = paying_users.pop(0)
        receiver = receiving_users.pop(0)

        pay_amount = min(-payer["deuda"], receiver["deuda"])

        if payer["id_usuario"] not in payments:
            payments[payer["id_usuario"]] = {}

        payments[payer["id_usuario"]][receiver["id_usuario"]] = f"{pay_amount:.2f}"

        payer["deuda"] += pay_amount
        receiver["deuda"] -= pay_amount

        if payer["deuda"] < 0:
            paying_users.insert(0, payer)
        if receiver["deuda"] > 0:
            receiving_users.insert(0, receiver)

    return payments


@app.route('/update-deudas/<int:group_id>', methods=['POST'])
def update_deudas(group_id):
    connection = connect_to_mysql(db_config.HOST, db_config.USER, db_config.PASSWORD, db_config.DATABASE, db_config.PORT)
    cursor = connection.cursor()

    # Step 1: Get the total per user
    # Query to calculate total per user
    query_total_per_user = "SELECT usuario_id, SUM(costo) as total FROM Articulos WHERE grupo_id = %s GROUP BY usuario_id"
    cursor.execute(query_total_per_user, (group_id,))
    total_por_usuario = [{"id_usuario": row[0], "total": row[1]} for row in cursor.fetchall()]

    # Step 2: Clear existing debts for the group
    query_clear_debts = "DELETE FROM Deudas WHERE grupo_id = %s"
    cursor.execute(query_clear_debts, (group_id,))

    # Step 3: Calculate the debts
    payments = calculate_payments({"totalPorUsuario": total_por_usuario})

    # Step 4: Insert the debts into the database
    for deudor_id, creditors in payments.items():
        for creditor_id, amount in creditors.items():
            query_insert_debt = "INSERT INTO Deudas (grupo_id, usuario_deudor_id, usuario_creditor_id, monto) VALUES (%s, %s, %s, %s)"
            cursor.execute(query_insert_debt, (group_id, deudor_id, creditor_id, amount))

    
    connection.commit()

    return jsonify({"message": "Deudas updated successfully", "deuda_por_usuario":payments}), 200


@app.route('/load-group-details/<int:group_id>', methods=['GET'])
def load_group_details(group_id):
    connection = connect_to_mysql(db_config.HOST, db_config.USER, db_config.PASSWORD, db_config.DATABASE, db_config.PORT)
    cursor = connection.cursor()

    # Query to get articles for the group
    query_articles = "SELECT id, nombre_articulo, costo, usuario_id FROM Articulos WHERE grupo_id = %s"
    cursor.execute(query_articles, (group_id,))
    articulos = [{"id": row[0], "nombre_articulo": row[1], "costo": row[2], "usuario_id": row[3]} for row in cursor.fetchall()]

    # Query to calculate total per user
    query_total_per_user = "SELECT usuario_id, SUM(costo) as total FROM Articulos WHERE grupo_id = %s GROUP BY usuario_id"
    cursor.execute(query_total_per_user, (group_id,))
    total_por_usuario = [{"id_usuario": row[0], "total": row[1]} for row in cursor.fetchall()]



    # Query to get users involved
    query_users = "SELECT id, nombre FROM Usuarios WHERE id IN (SELECT DISTINCT usuario_id FROM Articulos WHERE grupo_id = %s)"
    cursor.execute(query_users, (group_id,))
    usuarios = [{"id_usuario": row[0], "nombre_usuario": row[1]} for row in cursor.fetchall()]

    connection.close()

    # Constructing the final response
    response = {
        "articulos": articulos,
        "totalPorUsuario": total_por_usuario,
        "usuarios": usuarios
    }

    return jsonify(response), 200

if __name__ == '__main__':
    app.run(debug=True, port=2525) # Run the Flask api on port 2525
