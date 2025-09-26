#!/bin/bash

# --- Configuration ---
VENV_NAME="myenv"
PYTHON_SCRIPT="psu.py"

# --- Script Start ---
echo "--- Starting Hantek PSU Setup and Run Script ---"

# 1. Create a Python Virtual Environment
echo "1. Creating virtual environment '$VENV_NAME'..."
# Use 'python3' to ensure the correct interpreter is used
if python3 -m venv "$VENV_NAME"; then
    echo "Virtual environment created successfully."
else
    echo "ERROR: Failed to create virtual environment. Do you have python3-venv installed?"
    exit 1
fi

# 2. Activate the Virtual Environment and Install Dependencies
echo "2. Activating environment and installing 'hantekpsu'..."
# Source the activation script
if source "$VENV_NAME/bin/activate"; then
    echo "Virtual environment activated."
else
    echo "ERROR: Failed to activate virtual environment."
    exit 1
fi

# Install the required package
if pip install hantekpsu; then
    echo "'hantekpsu' installed successfully."
else
    echo "ERROR: Failed to install 'hantekpsu'. Check your internet connection."
    # Deactivate the environment before exiting
    deactivate
    exit 1
fi

# 3. Run the Python Script
echo "3. Running the Python script '$PYTHON_SCRIPT'..."
# The 'python' command inside an active virtual environment points to the venv's interpreter
if python "$PYTHON_SCRIPT"; then
    echo "Python script finished successfully."
else
    echo "ERROR: Python script failed."
fi

# 4. Deactivate the Virtual Environment
echo "4. Deactivating virtual environment..."
deactivate

echo "--- Script Finished ---"
