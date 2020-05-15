ARG APP_ROOT=/app

FROM ubuntu:bionic

# Install Dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get install -y  --no-install-recommends \
            git \
            default-jdk \
            ruby \
            ruby-dev \
            memcached \
            mysql-client \
            libmysqlclient-dev \
            libssl-dev \
            ant \
            unzip \
            curl \
            build-essential \
            sqlite3 \
            libsqlite3-dev \
    && apt-get purge -y --auto-remove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
              /tmp/*

RUN gem install bundler -v 1.17.3

ARG APP_ROOT
ENV APP_ROOT=${APP_ROOT}
ENV SERVER_ROOT=${APP_ROOT}/server
ENV CLIENT_ROOT=${APP_ROOT}/client
ENV DIST_DIR=${APP_ROOT}/dist

# Setup Application
RUN mkdir -p $SERVER_ROOT \
             $CLIENT_ROOT \
             $DIST_DIR
WORKDIR $CLIENT_ROOT

# Setup Server
COPY server/Gemfile* $SERVER_ROOT/
RUN cd $SERVER_ROOT && bundle install

# Setup Flex
ENV FLEXSDK_VERSION 3.6a
RUN curl -fL -o /tmp/flexsdk.zip http://download.macromedia.com/pub/flex/sdk/flex_sdk_${FLEXSDK_VERSION}.zip \
    && unzip /tmp/flexsdk.zip -d /usr/lib/flex3 \
    && rm -rf /tmp/*

# Add Source Files
ADD src/app $APP_ROOT
ADD server/ $SERVER_ROOT
ADD client/ $CLIENT_ROOT
ADD patches/ /app/patches

ENV PATH $CLIENT_ROOT/bin:$PATH

# Prepare necessary directory
RUN mkdir -p $SERVER_ROOT/bin/pids \
    && mkdir -p $SERVER_ROOT/data/backup \
    && mkdir -p $CLIENT_ROOT/script/data

# Apply patch
RUN sh $CLIENT_ROOT/scripts/prepare.sh \
    && sh $CLIENT_ROOT/scripts/patch.sh
