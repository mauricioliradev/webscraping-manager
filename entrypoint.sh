#!/bin/bash
set -e

# Remove server.pid antigo se existir
rm -f /rails/tmp/pids/server.pid

if [ "$1" == "./bin/rails" ] && [ "$2" == "server" ]; then
  echo "Verificando banco de dados..."
  bundle exec rails db:prepare

  echo "Compilando Tailwind CSS..."
  bundle exec rails tailwindcss:build
fi

exec "$@"