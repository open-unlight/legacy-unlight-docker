ARG APP_ROOT=/app
ARG RUBY_VERSION=2.6

# Pre-compile Gems
FROM ruby:${RUBY_VERSION}-alpine AS gem

RUN apk --update \
        add --no-cache \
        build-base \
        ca-certificates \
        zlib-dev \
        libressl-dev \
        mariadb-dev \
        mariadb-client \
        sqlite \
        sqlite-dev

# Setup Application
ARG APP_ROOT
ENV APP_ROOT=${APP_ROOT}
ENV SERVER_ROOT=$APP_ROOT/server

RUN mkdir -p $SERVER_ROOT
WORKDIR $SERVER_ROOT

COPY server/Gemfile* $SERVER_ROOT/
RUN cd $SERVER_ROOT \
    && bundle install --deployment --no-cache --without development \
    && rm -rf vendor/bundle/ruby/**/cache

# Server
FROM ruby:${RUBY_VERSION}-alpine

RUN apk --update \
        add --no-cache \
        gcc \
        libc-dev \
        ca-certificates \
        zlib-dev \
        libressl-dev \
        mariadb-connector-c \
        mariadb-client \
        sqlite

ARG APP_ROOT
ENV APP_ROOT=${APP_ROOT}
ENV SERVER_ROOT=$APP_ROOT/server

# Setup Application
RUN mkdir -p $SERVER_ROOT \
      && mkdir -p $SERVER_ROOT/bin/pids \
      && mkdir -p $SERVER_ROOT/data/backup
WORKDIR $SERVER_ROOT

COPY --from=gem $SERVER_ROOT/vendor/bundle $SERVER_ROOT/vendor/bundle
COPY --from=gem /usr/local/bundle/config /usr/local/bundle/config

# Add Source Files
ADD src/app/server/ $SERVER_ROOT
ADD server/ $SERVER_ROOT
ADD patches/ $APP_ROOT/patches

ENV PATH $SERVER_ROOT/bin:$PATH

# Patch for Dockerize
RUN sh $SERVER_ROOT/scripts/prepare.sh \
    && sh $SERVER_ROOT/scripts/patch.sh
