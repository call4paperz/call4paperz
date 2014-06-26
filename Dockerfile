FROM ubuntu:14.04
MAINTAINER Ricardo Valeriano <ricardo.valeriano+c4p@gmail.com>
RUN apt-get update
RUN apt-get install -yqq ca-certificates

## Brightbox Ruby 1.9.3, 2.0 and 2.1
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3173AA6
RUN echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main > /etc/apt/sources.list.d/brightbox.list
RUN apt-get update

RUN apt-get install -yqq python-software-properties libxslt-dev libxml2-dev ruby1.9.1 ruby1.9.1-dev
RUN gem update --system
RUN gem install rake bundler --no-rdoc --no-ri
