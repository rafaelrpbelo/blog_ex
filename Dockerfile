# Get elixir latest image from docker
FROM elixir:latest

# Set DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Set Node version
ENV NODE_VERSION=4.4.7

# Update package control
RUN apt-get update

# Get NodeJS
RUN curl -sSL "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" | tar xfJ - -C /usr/local --strip-components=1 && \
  npm install npm -g

# Install Hex
RUN mix local.hex --force

# Install Rebar
RUN mix local.rebar --force

# Install lastest phoenix version
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# Install inotify-tools
RUN apt-get install -y inotify-tools
