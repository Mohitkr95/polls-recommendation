# Define paths and executables
HOME_PATH := /home/mohitkumar/Desktop/MLOps
VENV_PATH := $(HOME_PATH)/env

# Automatically find python and pip within the virtual environment
PYTHON := $(VENV_PATH)/bin/python
PIP := $(VENV_PATH)/bin/pip

# Environment setup
ACTIVATE_VENV := . $(VENV_PATH)/bin/activate
SHELL := /bin/bash
.ONESHELL:

# Makefile's default behavior
.PHONY: all setup clean_data convert_interactions prepare_model train_personalization_model evaluate
export PYTHONDONTWRITEBYTECODE=1

all: setup train_personalization_model evaluate

setup: | $(VENV_PATH)
	$(ACTIVATE_VENV)
	$(PIP) install --upgrade pip
	if [ -z "$$($(PIP) freeze | grep -F -x -f $(HOME_PATH)/requirements.txt)" ]; then \
		echo "Installing/updating required packages."
		$(PIP) install -r $(HOME_PATH)/requirements.txt
	else
		echo "Virtual environment already has required packages installed."
	fi

$(VENV_PATH):
	echo "Creating virtual environment."
	python3.10 -m venv $(VENV_PATH)

clean_data:
	echo "Cleaning data."
	$(ACTIVATE_VENV) && jupyter nbconvert --to notebook --execute --inplace $(HOME_PATH)/events_clean.ipynb

convert_interactions: clean_data
	echo "Converting interactions."
	$(ACTIVATE_VENV) && jupyter nbconvert --to notebook --execute --inplace $(HOME_PATH)/raw_events_to_interactions.ipynb

prepare_model: convert_interactions
	echo "Preparing model."
	$(ACTIVATE_VENV) && jupyter nbconvert --to notebook --execute --inplace $(HOME_PATH)/prepare_for_model.ipynb

train_personalization_model: prepare_model
	echo "Training personalization model."
	$(ACTIVATE_VENV) && jupyter nbconvert --to notebook --execute --inplace $(HOME_PATH)/model_experiments.ipynb

evaluate:
	echo "Evaluation complete."