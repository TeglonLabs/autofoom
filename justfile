# Justfile for autofoom testing

# Default recipe to run when just is called without arguments
default:
    @just --list

# One-command guaranteed setup and run with optimal configuration
run:
    @echo "🌀 Setting up autofoom with optimal configuration..."
    @cd autofoom && \
    rm -rf .venv || true && \
    uv venv --python=3.11 && \
    . .venv/bin/activate && \
    uv pip install -e . && \
    @echo "🚀 Launching autofoom UI with enhanced settings..." && \
    export OPENAI_API_KEY=${OPENAI_API_KEY:-"sk-demo-key"} && \
    export HYPERBOLIC_API_KEY=${HYPERBOLIC_API_KEY:-"hb-demo-key"} && \
    python -c "import os; print(f'\033[1;36m✨ Using model: {os.getenv(\"DEFAULT_CLASSIFIER\", \"gpt-4\")} | Temperature: 0.8 | Max Tokens: 150\033[0m')" && \
    lui

# Setup a uv environment and install the package
setup:
    cd autofoom && \
    rm -rf .venv || true && \
    uv venv && \
    . .venv/bin/activate && \
    uv pip install -e .

# Run the lui UI
run-lui:
    cd autofoom && \
    . .venv/bin/activate && \
    lui

# Run the tuni tuner
run-tuni:
    cd autofoom && \
    . .venv/bin/activate && \
    tuni

# Clean build artifacts and virtual environments
clean:
    rm -rf autofoom/.venv
    rm -rf autofoom/__pycache__
    rm -rf autofoom/**/__pycache__
    
# Test installation and imports
test-imports:
    cd autofoom && \
    . .venv/bin/activate && \
    python -c "import lui; import tuni; print('Imports successful!')"

# Compare with old poetry instructions for reference
poetry-ref:
    @echo "Old poetry commands were:"
    @echo "poetry install"
    @echo "poetry run lui"
    @echo "poetry run tuni"
    @echo ""
    @echo "New uv commands are:"
    @echo "uv venv && . .venv/bin/activate && uv pip install -e ."
    @echo "lui"
    @echo "tuni"