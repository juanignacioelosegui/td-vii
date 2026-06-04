from datetime import datetime
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.empty import EmptyOperator

with DAG(
    dag_id="ej_1_introduccion_airflow_enunciado",
    start_date=datetime(2026, 1, 1),
    schedule="@daily",
    catchup=False,
    tags=["demo", "basico"],
) as dag:

    inicio = EmptyOperator(task_id="inicio")

    #crear_directorio = BashOperator(...)

    #descargar_logs = BashOperator(...

    fin = EmptyOperator(task_id="fin")

    # Definición de las dependencias (el pipeline)
    inicio >> fin
    # inicio >> crear_directorio >> descargar_logs >> fin