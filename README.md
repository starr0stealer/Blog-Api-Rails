# Blog API

> Example Rails RESTful API for a prototype blog application

## Environment

- Ruby 2.4.4
- Rails 5.2
- SQLite

## Setup

- Clone repo
- `bundle install`
- `rails credentials:edit`
  - *note: no keys need to be added, just the default secret_key_base*
- `rake db:migrate`
- `rails server`

## Dependencies

- Jbuilder
- Devise
- Devise JWT
