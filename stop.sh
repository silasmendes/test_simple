#!/bin/bash

# Script para parar o projeto tanto localmente quanto no Codespaces

echo "🛑 Parando containers..."

# Detecta qual comando docker compose usar
if command -v "docker" >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
    DOCKER_COMPOSE_CMD="docker compose"
elif command -v "docker-compose" >/dev/null 2>&1; then
    DOCKER_COMPOSE_CMD="docker-compose"
else
    echo "❌ ERRO: Nem 'docker compose' nem 'docker-compose' foram encontrados!"
    exit 1
fi

# Detecta se estamos no Codespaces
if [ "$CODESPACES" = "true" ]; then
    echo "📦 Ambiente detectado: GitHub Codespaces"
    $DOCKER_COMPOSE_CMD -f docker-compose.codespaces.yml down
else
    echo "💻 Ambiente detectado: Desenvolvimento local"
    $DOCKER_COMPOSE_CMD down
fi

echo "✅ Containers parados com sucesso!"
