# Flask + PostgreSQL Project

Este projeto é uma aplicação Flask simples que se conecta a um banco PostgreSQL, com suporte para desenvolvimento tanto local quanto no GitHub Codespaces.

## 🚀 Início Rápido

### Desenvolvimento Local

1. **Configurar variáveis de ambiente:**
   ```bash
   cp .env.example .env
   ```
   
2. **Editar o arquivo `.env`** com suas configurações:
   ```
   POSTGRES_USER=seu_usuario
   POSTGRES_PASSWORD=sua_senha
   POSTGRES_DB=nome_do_banco
   POSTGRES_HOST=db
   ```

3. **Iniciar o projeto:**
   ```bash
   ./start.sh
   ```

4. **Acessar a aplicação:**
   - http://localhost:5000

5. **Parar o projeto:**
   ```bash
   ./stop.sh
   ```

### GitHub Codespaces

1. **Configurar secrets** no repositório GitHub:
   - `POSTGRES_USER`
   - `POSTGRES_PASSWORD`
   - `POSTGRES_DB`

2. **Abrir no Codespaces** - o ambiente será configurado automaticamente

3. **Iniciar o projeto** (se necessário):
   ```bash
   ./start.sh
   ```

## 📁 Estrutura do Projeto

```
├── app.py                          # Aplicação Flask principal
├── requirements.txt                # Dependências Python
├── Dockerfile                      # Configuração do container da aplicação
├── docker-compose.yml              # Configuração para desenvolvimento local
├── docker-compose.codespaces.yml   # Configuração para Codespaces
├── start.sh                        # Script inteligente de inicialização
├── stop.sh                         # Script para parar os containers
├── .env.example                    # Exemplo de configuração
├── .devcontainer/                  # Configuração do Codespaces
│   └── devcontainer.json
└── README.md                       # Este arquivo
```

## 🔧 Comandos Úteis

### Docker Compose Manual

**Desenvolvimento Local:**
```bash
docker-compose up --build -d
docker-compose down
```

**Codespaces:**
```bash
docker-compose -f docker-compose.codespaces.yml up --build -d
docker-compose -f docker-compose.codespaces.yml down
```

### Logs
```bash
docker-compose logs -f
```

### Acessar o container
```bash
docker-compose exec app bash
```

## 🌍 Variáveis de Ambiente

| Variável | Descrição | Exemplo |
|----------|-----------|---------|
| `POSTGRES_USER` | Usuário do PostgreSQL | `myuser` |
| `POSTGRES_PASSWORD` | Senha do PostgreSQL | `mypassword` |
| `POSTGRES_DB` | Nome do banco de dados | `mydatabase` |
| `POSTGRES_HOST` | Host do PostgreSQL | `db` (local) ou `localhost` |

## 🐛 Troubleshooting

### Problema: Containers não sobem no Codespaces
- Verifique se os secrets estão configurados corretamente no GitHub
- Execute `./start.sh` para ver mensagens de erro detalhadas

### Problema: Erro de conexão com banco
- Verifique se as variáveis de ambiente estão corretas
- Aguarde alguns segundos para o PostgreSQL inicializar completamente

### Problema: Porta já em uso
```bash
./stop.sh  # Para todos os containers
docker-compose ps  # Verifica containers rodando
```