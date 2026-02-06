#!/bin/bash
set -e

# Remove um arquivo server.pid potencialmente pré-existente para o Rails.
rm -f /rails/tmp/pids/server.pid

# Executa o comando principal do container
exec "$@"