#!/bin/zsh

# Checking for existence of .venv
if [ ! -d ".venv" ]; then
  echo "Creating virtual environment."
  python3 -m venv .venv
else
  echo ".venv already exists. Skipping creation."
fi

# Activate the .venv
source .venv/bin/activate
echo "Activated .venv!"

# Upgrade pip
echo "Upgrading pip."
pip install --upgrade pip

# Install dependencies
if [ -f "requirements.txt" ]; then
  echo "Installing dependencies from requirements.txt."
  pip install -r requirements.txt
else
  echo "No requirements.txt found. Skipping package installation."
fi

echo "Setup complete. Virtual environment activated!"


