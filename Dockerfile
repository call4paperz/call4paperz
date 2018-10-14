FROM ruby:2.5.1-slim

RUN apt-get update && \
    apt-get install -y build-essential nodejs libpq-dev postgresql-client imagemagick

ENV APP_PATH /var/www/app

WORKDIR $APP_PATH

COPY Gemfile* $APP_PATH/

ENV \
  BUNDLE_GEMFILE=$APP_PATH/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/var/www/app/.bundle

RUN bundle install

COPY . $APP_PATH/
