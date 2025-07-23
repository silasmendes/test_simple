#!/bin/bash

# Script para inicializar o projeto tanto localmente quanto no Codespaces

set -e

echo "🚀 Inicializando projeto..."

# Detecta qual comando docker compose usar
if command -v "docker" >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
    DOCKER_COMPOSE_CMD="docker compose"
    echo "🐳 Usando: docker compose (novo)"
elif command -v "docker-compose" >/dev/null 2>&1; then
    DOCKER_COMPOSE_CMD="docker-compose"
    echo "🐳 Usando: docker-compose (legacy)"
else
    echo "❌ ERRO: Nem 'docker compose' nem 'docker-compose' foram encontrados!"
    echo "   Por favor, instale o Docker e Docker Compose"
    exit 1
fi

# Detecta se estamos no Codespaces
if [ "$CODESPACES" = "true" ]; then
    echo "📦 Ambiente detectado: GitHub Codespaces"
    
    # Verifica se as variáveis de ambiente estão configuradas
    if [ -z "$POSTGRES_USER" ] || [ -z "$POSTGRES_PASSWORD" ] || [ -z "$POSTGRES_DB" ]; then
        echo "❌ ERRO: Variáveis de ambiente não encontradas!"
        echo "   Por favor, configure os seguintes secrets no Codespaces:"
        echo "   - POSTGRES_USER"
        echo "   - POSTGRES_PASSWORD" 
        echo "   - POSTGRES_DB"
        exit 1
    fi
    
    echo "✅ Variáveis de ambiente encontradas"
    echo "🐳 Iniciando containers com docker-compose.codespaces.yml..."
    $DOCKER_COMPOSE_CMD -f docker-compose.codespaces.yml up --build -d
    
else
    echo "💻 Ambiente detectado: Desenvolvimento local"
    
    # Verifica se existe arquivo .env
    if [ ! -f ".env" ]; then
        echo "❌ ERRO: Arquivo .env não encontrado!"
        echo "   Por favor, copie .env.example para .env e configure as variáveis:"
        echo "   cp .env.example .env"
        exit 1
    fi
    
    echo "✅ Arquivo .env encontrado"
    echo "🐳 Iniciando containers com docker-compose.yml..."
    $DOCKER_COMPOSE_CMD up --build -d
fi

echo ""
echo "🎉 Projeto iniciado com sucesso!"
echo "📍 Aplicação disponível em: http://localhost:5000"
echo ""
echo "Para parar os containers:"
if [ "$CODESPACES" = "true" ]; then
    echo "   $DOCKER_COMPOSE_CMD -f docker-compose.codespaces.yml down"
else
    echo "   $DOCKER_COMPOSE_CMD down"
fi
