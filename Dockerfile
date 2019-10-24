FROM ruby:2.6.5-slim

RUN apt-get update && \
    apt-get install -y build-essential nodejs libpq-dev postgresql-client imagemagick

ENV APP_PATH /var/www/app

WORKDIR $APP_PATH

COPY Gemfile* $APP_PATH/

RUN bundle install

COPY . $APP_PATH/
