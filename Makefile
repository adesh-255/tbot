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

	@echo "Checking if the container exists..."
	@CID=$$(docker ps -a -f "name=adeshina_bot" --format "{{.ID}}"); \
	if [ -z "$$CID" ]; then \
		echo "Container does not exist."; \
	else \
		echo "Container exists. Stopping and removing..."; \
		docker stop $$CID; \
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