from datetime import datetime, timedelta
import requests
import json
from airflow.decorators import dag, task

default_args = {
    "owner": "data_team",
    "retries": 2,                           # Si la API falla, reintenta 2 veces
    "retry_delay": timedelta(seconds=30),   # Espera 30 segundos entre reintentos
}

@dag(
    dag_id="ej_3_etl_produccion_api_enunciado",
    default_args=default_args,
    start_date=datetime(2026, 1, 1),
    schedule="@hourly",                     # Se ejecuta cada hora
    catchup=False,
    tags=["demo", "avanzado", "etl"],
)
def etl_api_users():

    @task
    def extraer_usuarios_api():
        url = "https://jsonplaceholder.typicode.com/users"
        response = requests.get(url)
        response.raise_for_status() # Lanza error si la API responde mal, activando el retry
        return response.json()

    @task
    def transformar_y_filtrar(usuarios: list):
        # Extraemos solo la info relevante para el negocio
        return

    @task
    def guardar_en_destino(datos_finales: list):
        # En la realidad acá usarías un PostgresOperator, SnowflakeOperator o guardarías en S3/Sftp
        # Para la demo, simulamos un guardado escribiendo un archivo local indexado por fecha
        return

    # Flujo de ejecución
    raw_data = extraer_usuarios_api()
    clean_data = transformar_y_filtrar(raw_data)
    guardar_en_destino(clean_data)

dag_etl = etl_api_users()