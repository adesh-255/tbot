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
	@echo "Checking if a container is using port 8003..."
	@CID=$$(docker ps -a --filter "publish=8003" --format="{{.ID}}"); \
	if [ -z "$$CID" ]; then \
		echo "No container found on port 8003."; \
	else \
		echo "Stopping container $$CID..."; \
		docker stop $$CID; \
		echo "Removing container $$CID..."; \
		docker rm $$CID; \
	fi
	@echo "Deploying the project..."
	docker run -d -p 8003:80 adeshinadede/adeshina_bot
serve:
	@echo "Starting development server..."
	.venv/bin/fastapi dev src/main.py

test:
	@echo "Running tests..."
	.venv/bin/pytest