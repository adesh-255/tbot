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
	@echo "Checking if the container is running..."
	@if [ $$(docker ps -q -f name=adeshina_bot) ]; then \
		echo "Stopping existing container..."; \
		docker stop adeshina_bot; \
		echo "Removing existing container..."; \
		docker rm adeshina_bot; \
	fi
	@echo "Deploying the project..."
	docker run -d --name adeshina_bot -p 8003:80 adeshinadede/adeshina_bot
serve:
	@echo "Starting development server..."
	.venv/bin/fastapi dev src/main.py

test:
	@echo "Running tests..."
	.venv/bin/pytest