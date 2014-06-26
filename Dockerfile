FROM ubuntu:14.04
MAINTAINER Ricardo Valeriano <ricardo.valeriano+c4p@gmail.com>
RUN apt-get update

RUN apt-get install -yqq git wget gcc make libxslt-dev libxml2-dev

# rbenving the stuff
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN git clone git://github.com/tpope/rbenv-aliases.git

RUN $HOME/.rbenv/bin/rbenv install 1.9.3-p547
RUN $HOME/.rbenv/bin/rbenv global 1.9.3
RUN gem update --system
RUN gem install bundler --no-rdoc --no-ri
