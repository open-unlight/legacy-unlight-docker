#!/usr/bin/env sh

# TODO: Allow specify language
patch -p0 < patches/import_csv_data.rb.patch

# Dockerize
patch -p0 < patches/constants.rb.patch
patch -p0 < patches/server.patch
