# Use the official apache/airflow image with Python 3.8 as the base
FROM apache/airflow:2.3.0-python3.8

# Upgrade pip
RUN python -m pip install --upgrade pip

# Install gcc and other essential build tools
# Necessary for compiling certain package dependencies that have C extensions
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER airflow

# Install additional packages
RUN pip install --no-cache-dir \
    fuzzywuzzy \
    ipython \
    matplotlib \
    numpy \
    pandarallel \
    pandas \
    plotly \
    python-box \
    scikit-learn \
    seaborn \
    skimpy \
    scikit-surprise

# This assumes that your Docker context is set to your project root directory
COPY . /opt/airflow

# Set the working directory to the Airflow home directory
WORKDIR /opt/airflow

VOLUME [ "/data" ]