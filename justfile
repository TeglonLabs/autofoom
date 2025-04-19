# Justfile for autofoom testing

# Default recipe to run when just is called without arguments
default:
    @just --list

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