FROM ubuntu:16.04
MAINTAINER Alican Erdogan <aerdogan07@gmail.com>

RUN apt-get update && \
    apt-get install -y language-pack-en-base && \
    locale-gen "en_US.UTF-8"

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apt-get install -y sudo wget git nano

RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb && \
    apt-get update && \
    apt-get install -y esl-erlang && \
    apt-get install -y elixir && \
    apt-get install make build-essential -y

RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force
