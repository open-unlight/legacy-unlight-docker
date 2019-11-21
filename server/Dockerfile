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
RUN mkdir -p $APP_ROOT/server

WORKDIR $APP_ROOT/

COPY server/Gemfile* $APP_ROOT/server/
RUN cd $APP_ROOT/server \
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

# Setup Application
RUN mkdir -p $APP_ROOT/server \
      && mkdir -p $APP_ROOT/server/bin/pids \
      && mkdir -p $APP_ROOT/server/data/backup

WORKDIR $APP_ROOT/

COPY --from=gem $APP_ROOT/server/vendor/bundle $APP_ROOT/server/vendor/bundle
COPY --from=gem /usr/local/bundle/config /usr/local/bundle/config

# Add Source Files
ADD src/app/server/ $APP_ROOT/server
ADD server/ $APP_ROOT/server
ADD patches/ $APP_ROOT/patches

ENV PATH $APP_ROOT/server/bin:$PATH

# Apply patch
RUN cp $APP_ROOT/server/src/server_ip.rb_orig $APP_ROOT/server/src/server_ip.rb \
    && cp $APP_ROOT/server/src/constants/locale_constants.rb_sb $APP_ROOT/server/src/constants/locale_constants.rb \
    # Missing
    && cp $APP_ROOT/server/src/constants/locale_constants.rb_sb $APP_ROOT/server/src/constants/locale_constants.rb_tcn \
    && cp $APP_ROOT/server/src/net/crypt.rb_orig $APP_ROOT/server/src/net/crypt.rb

RUN patch -p0 < patches/import_csv_data.rb.patch \
    && patch -p0 < patches/constants.rb.patch \
    # For run server inside docker
    && patch -p0 < patches/server.patch \
    # For direct test game
    && patch -p0 < patches/disable_server_encrypt.patch
