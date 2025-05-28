#!/bin/zsh
set -e

# Initialize pyenv
#echo "$PATH" | tr ':' '\n'
echo "Initializing pyenv"
eval "$(pyenv init - zsh)"
eval "$(pyenv virtualenv-init - zsh)"

PYTHON_VERSION=3.11.4
echo "Setting pyenv shell to $PYTHON_VERSION"
pyenv shell $PYTHON_VERSION

# Confirm which python and version after setting pyenv shell
echo "Which python is active?"
which python
python --version

# Checking for existence of .venv
if [ ! -d ".venv" ]; then
  echo "Creating virtual environment."
  python -m venv .venv
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