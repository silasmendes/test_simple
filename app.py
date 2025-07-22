from flask import Flask
from sqlalchemy import create_engine, text
import os

app = Flask(__name__)

# Conexão com o PostgreSQL usando variáveis de ambiente
db_user = os.getenv("POSTGRES_USER")
db_pass = os.getenv("POSTGRES_PASSWORD")
db_host = os.getenv("POSTGRES_HOST", "db")  # "db" é o nome do serviço no docker-compose
db_name = os.getenv("POSTGRES_DB")

db_url = f"postgresql://{db_user}:{db_pass}@{db_host}:5432/{db_name}"
engine = create_engine(db_url)

@app.route('/')
def home():
    try:
        with engine.connect() as conn:
            result = conn.execute(text("SELECT 'Conexão bem-sucedida com o PostgreSQL!'"))
            return result.scalar()
    except Exception as e:
        return f"Erro ao conectar ao banco: {e}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
