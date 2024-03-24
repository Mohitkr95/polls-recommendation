#!/usr/bin/env bash

# Define the path to your virtual environment and home path
HOME_PATH="/home/mohitkumar/Desktop/MLOps"
VENV_PATH="${HOME_PATH}/env"

# Activate the virtual environment
source "${VENV_PATH}/bin/activate"

# Ensure the html_export directory within the HOME_PATH exists
if [ ! -d "docs/html_export" ]; then
    mkdir docs/html_export
fi

# Process all notebook files, excluding the env directory
find . -path ./env -prune -o -name "*.ipynb" -print0 | while IFS= read -r -d $'\0' nb; do
    echo "Processing ${nb}"
    nb_filename=$(basename "${nb}" .ipynb)
    # Convert to HTML and save in the html_export directory
    jupyter nbconvert --execute --to html "${nb}" --output "${HOME_PATH}/docs/html_export/${nb_filename}"
    # Clear the output of the original notebook
    jupyter nbconvert --ClearOutputPreprocessor.enabled=True --inplace "${nb}"
done
