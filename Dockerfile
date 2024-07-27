# syntax=docker/dockerfile:1

FROM ruby:2.7.3-alpine

RUN apk add --update alpine-sdk postgresql-dev

RUN apk add --update nodejs npm

RUN gem install pg -v '1.2.3'

RUN gem install tzinfo -v '1.2.9' 

ENV APP_HOME=/home/tepoztecatl/app

RUN mkdir -p ${APP_HOME}

WORKDIR ${APP_HOME}

COPY . .

RUN bundle install --no-cache

RUN npm install && npm cache clean --force

RUN rm -rf /tmp/pids/server.pid

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]