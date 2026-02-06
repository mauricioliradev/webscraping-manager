#!/bin/bash
set -e

# Remove server.pid antigo se existir
rm -f /rails/tmp/pids/server.pid

# Tenta rodar as migrações/criação de banco apenas se for o comando de subir o servidor
# Isso evita rodar em comandos isolados ou no sidekiq desnecessariamente
if [ "$1" == "./bin/rails" ] && [ "$2" == "server" ]; then
  echo "🚀 Verificando banco de dados..."
  # Tenta criar o banco e roda migrações
  bundle exec rails db:prepare
fi

# Executa o comando principal do container
exec "$@"