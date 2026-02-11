# Webscraping Manager

Aplicação Rails 8 que centraliza tarefas de scraping da Webmotors. O projeto já está preparado para rodar dentro de containers via Docker/Kamal, mas também funciona em modo local tradicional.

## Requisitos

- Ruby 3.3+
- PostgreSQL 14+
- Redis (Sidekiq + Solid Queue)
- Node não é necessário: o Tailwind roda pelo gem `tailwindcss-rails`

## Configuração básica

1. Instale as dependências Ruby:

	```sh
	bundle install
	```

2. Configure as credenciais (`config/credentials.yml.enc`) e crie o banco:

	```sh
	bin/rails db:prepare
	```

3. Inicie os serviços auxiliares (Redis e Postgres) ou utilize `docker-compose up` na raiz para subir tudo junto.

## Ambientes de desenvolvimento

Use o script `bin/dev` para iniciar o servidor com recarga de estilos Tailwind automática:

```sh
bin/dev
```

O script executa o `rails server` e `rails tailwindcss:watch` em paralelo. Caso prefira rodar manualmente:

```sh
bin/rails server
bin/rails tailwindcss:watch
```

Para gerar os estilos antes de um deploy (ex.: em CI), utilize:

```sh
RAILS_ENV=production bin/rails assets:precompile
```

## Jobs e scraping

- `ScrapingJob` dispara o serviço `WebmotorsScraper`
- Sidekiq é o adaptador configurado em `config/application.rb`
- Use `bin/rails jobs:work` ou um processo Sidekiq separado para processar as filas

## Testes

Assim que for adicionado um conjunto de specs, rode:

```sh
bin/rails test
```

## Deploy

Kamal está configurado na pasta `.kamal/`. Consulte a documentação oficial para gerar os secrets e rodar `bin/kamal deploy`.
