FROM ruby:2.1.5

MAINTAINER Jhonathas Matos <jhonathas@gmail.com>

ENV ENV_WITH Docker

RUN apt-get update

# JS Runtime
RUN apt-get install -y nodejs --no-install-recommends

# PostgreSQL Client
RUN apt-get install -y postgresql-client --no-install-recommends

RUN rm -rf /var/lib/apt/lists/*

# Set the locale
ENV LANG C.UTF-8

RUN gem update --system
RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

WORKDIR /var/www

EXPOSE 3000
