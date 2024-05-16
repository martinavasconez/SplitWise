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




if __name__ == '__main__':
    app.run(debug=True, port=2525) # Run the Flask api on port 2525
