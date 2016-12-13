FROM ruby:2.3.1

RUN apt-get update
RUN apt-get install -y build-essential nodejs postgresql-client bundler

RUN mkdir -p /var/www/app
WORKDIR /var/www/app
COPY . /var/www/app

ENV BUNDLE_PATH=/var/www/app/bundle

RUN bundle install
