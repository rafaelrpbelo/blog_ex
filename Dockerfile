# Get elixir latest image from docker
FROM elixir:latest

# Set DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND=noninteractive \
  PHANTOMJS_VERSION=2.1.1

# Set Node version
ENV NODE_VERSION=7.5.0

# Update package control
RUN apt-get update

# Get NodeJS
RUN curl -sSL "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" | tar xfJ - -C /usr/local --strip-components=1 && \
  npm install npm -g

# Get PhantomJS
run curl -sSL "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2" | tar xfj - -C /usr/local && \
  ln -s /usr/local/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs

# Install Hex
RUN mix local.hex --force

# Install Rebar
RUN mix local.rebar --force

# Install lastest phoenix version
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# Install inotify-tools
RUN apt-get install -y inotify-tools
