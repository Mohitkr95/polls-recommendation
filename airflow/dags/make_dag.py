# Standard library imports
from datetime import datetime, timedelta
import time

# Third-party imports
from airflow import DAG
from airflow.operators.bash_operator import BashOperator

# Constants are typically named in all uppercase
DEFAULT_ARGS = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 3, 23),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5)
}

# Creating the DAG object
dag = DAG(
    dag_id='makefile_dag',
    default_args=DEFAULT_ARGS,
    description='A DAG to run Makefile targets',
    schedule_interval='@daily',  # Set to '@daily' to run the DAG daily
)

# Define the task to run Makefile
run_makefile_task = BashOperator(
    task_id='run_makefile',
    bash_command='make -f /home/mohitkumar/Desktop/MLOps/Makefile',
    dag=dag,
)
