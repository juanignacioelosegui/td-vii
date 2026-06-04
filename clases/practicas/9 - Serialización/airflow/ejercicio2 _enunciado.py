from datetime import datetime
from airflow.decorators import dag, task

@dag(
    dag_id="ej_2_taskflow_api_y_xcoms_enunciado",
    start_date=datetime(2026, 1, 1),
    schedule=None, # Se ejecuta manualmente
    catchup=False,
    tags=["demo", "intermedio"],
)
def mi_segundo_dag():

    @task
    def generar_datos():
        # Simula extraer datos de una fuente
        precios = [100, 250, 50, 400, 120]
        print(f"Datos generados: {precios}")
        return precios

    @task
    def filtrar_altos(valores: list):
        # Filtra valores mayores a 150
        return

    # Agregar una task que sume todos los elementos

    # Al usar el decorador @task, la dependencia se define al pasar las funciones como argumentos
    datos = generar_datos()
    datos_filtrados = filtrar_altos(datos)
    #calcular_total(datos_filtrados)

dag_ejecucion = mi_segundo_dag()