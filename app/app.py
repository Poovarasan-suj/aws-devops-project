import os
import time
import mysql.connector
from flask import Flask, request

app = Flask(__name__)


def get_db_connection():
    return mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        port=int(os.getenv("DB_PORT", 3306)),
        database=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD")
    )


@app.route("/")
@app.route("/")
def home():
    return """
    <!DOCTYPE html>
    <html>
    <head>
        <title>DevOps Login</title>
        <style>
            body {
                background-color: lightgreen;
                font-family: Arial, sans-serif;
                text-align: center;
                padding-top: 100px;
            }

            h1 {
                color: darkblue;
            }

            .box {
                background-color: white;
                width: 350px;
                margin: auto;
                padding: 30px;
                border-radius: 10px;
            }

            .button {
                background-color: green;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
            }
        </style>
    </head>

    <body>
        <div class="box">
            <h1>DevOps Login Application</h1>
            <p>Version 4.0</p>
            <a href="/login">
                <button class="button">Login</button>
            </a>
        </div>
    </body>
    </html>
    """


@app.route("/health")
def health():
    return "OK"


@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "GET":
        return """
        <h2>Login</h2>
        <form method="POST">
            Username: <input name="username"><br><br>
            Password: <input name="password" type="password"><br><br>
            <button type="submit">Login</button>
        </form>
        """

    username = request.form.get("username")
    password = request.form.get("password")

    try:
        connection = get_db_connection()
        cursor = connection.cursor()

        cursor.execute(
            "SELECT username FROM users WHERE username=%s AND password=%s",
            (username, password)
        )

        user = cursor.fetchone()

        cursor.close()
        connection.close()

        if user:
            return "Login successful!"

        return "Invalid username or password", 401

    except mysql.connector.Error as error:
        return f"Database error: {error}", 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)


###Function for our unit testing practice
def calculate_total(price, quantity):
    return price * quantity