# Tepoztecatl

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/huasteka/tepoztecatl/tree/master.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/huasteka/tepoztecatl/tree/master)
[![Maintainability](https://api.codeclimate.com/v1/badges/20fea2a0d1588db0cae9/maintainability)](https://codeclimate.com/github/huasteka/tepoztecatl/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/20fea2a0d1588db0cae9/test_coverage)](https://codeclimate.com/github/huasteka/tepoztecatl/test_coverage)

Tepoztecatl is a simple open source API for optimal inventory control, developed with [Ruby on Rails](http://rubyonrails.org).

## Setup

- [PostgreSQL](http://www.postgresql.org) (>= 9.3)
- [Ruby](https://www.ruby-lang.org/en) (>= 2.7.3)

After installing **Ruby**, open a terminal and run this command to install [Bundler](http://bundler.io/):

```sh
gem install bundler
```

## Installation

To download and build the project, open a terminal and execute:

```sh
git clone https://github.com/huasteka/tepoztecatl.git
cd tepoztecatl
bundle install
```

To serve the project run: `rails s` the application will be served at `http://localhost:9702`.

## Configuration

To configure database credentials modify `config/database.yml` file:

```yml
[environment]:
  <<: *default
  database: [database_name]
  username: [database_user]
  password: [database_password]
```

To run the database migrations, open a terminal and execute:

```sh
rake db:create
rake db:migrate
```

## Tests

To execute all tests, open a terminal and execute:

```sh
bundle exec rspec
```

## Run

To run the application, open a terminal and execute:

```sh
rails s
```

## License

Tepoztecatl is Copyright © 2017 Huasteka.

It is free software, and may be redistributed under the terms specified in the [LICENSE.md](LICENSE.md)
