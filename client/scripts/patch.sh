#!/usr/bin/env sh

cd $APP_ROOT
# Prepare server for dump data
patch -p0 < $APP_ROOT/patches/server.patch

patch -p0 < $APP_ROOT/patches/import_csv_data.rb.patch
patch -p0 < $APP_ROOT/patches/create_const_data.rb.patch
patch -p0 < $APP_ROOT/patches/create_font_swf.rb.patch
patch -p0 < $APP_ROOT/patches/constants.rb.patch

# Compile client with SQLite
patch -p0 < $APP_ROOT/patches/Unlight-config.xml.patch
find $APP_ROOT/patches/compile -type f | xargs cat | patch -p0
