# Tepoztecatl

[![Travis](https://img.shields.io/travis/huasteka/tepoztecatl.svg?style=flat-square)](https://travis-ci.org/huasteka/tepoztecatl)
[![GitHub issues](https://img.shields.io/github/issues/huasteka/tepoztecatl.svg?style=flat-square)](https://github.com/huasteka/tepoztecatl/issues)
[![Maintainability](https://api.codeclimate.com/v1/badges/44e1c70362a53f32662d/maintainability)](https://codeclimate.com/github/huasteka/tepoztecatl/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/44e1c70362a53f32662d/test_coverage)](https://codeclimate.com/github/huasteka/tepoztecatl/test_coverage)
[![Codecov](https://codecov.io/gh/huasteka/tepoztecatl/branch/master/graph/badge.svg)](https://codecov.io/gh/huasteka/tepoztecatl)

Tepoztecatl is an open source simple API for optimal inventory control developed with [Ruby on Rails](http://rubyonrails.org).

## Setup

- [PostgreSQL](http://www.postgresql.org) (>= 9.3)
- [Ruby](https://www.ruby-lang.org/en) (>= 2.2.4)

After installing **Ruby**, open a terminal and run this command to install [Bundler](http://bundler.io/):

```
gem install bundler
```

## Installation

To download and build the project, open a terminal and execute:

```
git clone https://github.com/huasteka/tepoztecatl.git
cd tepoztecatl
bundle install
```

To serve the project run: `rails s` the application will be served at `http://localhost:9702`.

## Configuration

To configure database credentials modify `config/database.yml` file:

```
[environment]:
  <<: *default
  database: [database_name]
  username: [database_user]
  password: [database_password]
```

## Tests

To execute all tests, open a terminal and execute:

```
bundle exec rspec
```

## License

Tepoztecatl is Copyright © 2017 Huasteka.

It is free software, and may be redistributed under the terms specified in the [LICENSE.md](LICENSE.md)
