.phony = help install serve-dev

venv:
	@echo "Creating virtual environment..."
	python3 -m venv .venv

install:
	@echo "Installing dependencies..."
	.venv/bin/pip install --upgrade pip
	.venv/bin/pip install -r requirements.txt

build:
	@echo "Building the project..."
	docker build --no-cache -t adeshinadede/adeshina_bot .

make deploy:
	chmod +x deploy.sh
	./deploy.sh
serve:
	@echo "Starting development server..."
	.venv/bin/fastapi dev src/main.py

test:
	@echo "Running tests..."
	.venv/bin/pytest