.PHONY: help start stop logs clean install test

# Detecta qual comando docker compose usar
DOCKER_COMPOSE_CMD := $(shell if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then echo "docker compose"; elif command -v docker-compose >/dev/null 2>&1; then echo "docker-compose"; else echo ""; fi)

help: ## Mostra esta ajuda
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

start: ## Inicia o projeto (detecta automaticamente o ambiente)
	@./start.sh

stop: ## Para todos os containers
	@./stop.sh

logs: ## Mostra os logs dos containers
	@if [ "$(DOCKER_COMPOSE_CMD)" = "" ]; then \
		echo "❌ ERRO: Nem 'docker compose' nem 'docker-compose' foram encontrados!"; \
		exit 1; \
	fi
	@if [ "$$CODESPACES" = "true" ]; then \
		$(DOCKER_COMPOSE_CMD) -f docker-compose.codespaces.yml logs -f; \
	else \
		$(DOCKER_COMPOSE_CMD) logs -f; \
	fi

clean: ## Remove containers, volumes e imagens
	@echo "🧹 Limpando ambiente Docker..."
	@if [ "$(DOCKER_COMPOSE_CMD)" = "" ]; then \
		echo "❌ ERRO: Nem 'docker compose' nem 'docker-compose' foram encontrados!"; \
		exit 1; \
	fi
	@if [ "$$CODESPACES" = "true" ]; then \
		$(DOCKER_COMPOSE_CMD) -f docker-compose.codespaces.yml down -v --remove-orphans; \
	else \
		$(DOCKER_COMPOSE_CMD) down -v --remove-orphans; \
	fi
	@docker system prune -f
	@echo "✅ Limpeza concluída!"

install: ## Instala dependências localmente (fora do Docker)
	@echo "📦 Instalando dependências..."
	@pip install -r requirements.txt
	@echo "✅ Dependências instaladas!"

rebuild: ## Reconstrói e reinicia os containers
	@echo "🔄 Reconstruindo containers..."
	@make stop
	@make start
	@echo "✅ Containers reconstruídos!"

status: ## Mostra o status dos containers
	@if [ "$(DOCKER_COMPOSE_CMD)" = "" ]; then \
		echo "❌ ERRO: Nem 'docker compose' nem 'docker-compose' foram encontrados!"; \
		exit 1; \
	fi
	@if [ "$$CODESPACES" = "true" ]; then \
		$(DOCKER_COMPOSE_CMD) -f docker-compose.codespaces.yml ps; \
	else \
		$(DOCKER_COMPOSE_CMD) ps; \
	fi
