# Sintaxe para garantir compatibilidade
ARG RUBY_VERSION=3.4.7

FROM ruby:$RUBY_VERSION-slim

# Instala dependências essenciais do Linux
# build-essential: para compilar gems nativas
# libpq-dev: para conectar no Postgres
# git: para gems que vêm do github
# curl: utilitários de rede
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev git curl libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*
# Diretório de trabalho dentro do container
WORKDIR /rails

# Copia os arquivos de dependência primeiro
COPY Gemfile Gemfile.lock ./

# Instala as gems
RUN bundle install

# Copia o restante do código
COPY . .

# Adiciona script para corrigir problema de PID do servidor
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expõe a porta padrão
EXPOSE 3000

# Comando padrão (pode ser sobrescrito pelo docker-compose)
CMD ["rails", "server", "-b", "0.0.0.0"]