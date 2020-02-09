#!/usr/bin/env sh

cd $APP_ROOT
# TODO: Allow specify language
patch -p0 < $APP_ROOT/patches/import_csv_data.rb.patch

# Dockerize
patch -p0 < $APP_ROOT/patches/constants.rb.patch
patch -p0 < $APP_ROOT/patches/crypt.rb.patch
patch -p0 < $APP_ROOT/patches/server.patch
