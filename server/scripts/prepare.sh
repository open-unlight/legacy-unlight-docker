#!/usr/bin/env sh

# Initialize
cp $APP_ROOT/server/src/server_ip.rb_orig $APP_ROOT/server/src/server_ip.rb
cp $APP_ROOT/server/src/constants/locale_constants.rb_sb $APP_ROOT/server/src/constants/locale_constants.rb
cp $APP_ROOT/server/src/net/crypt.rb_orig $APP_ROOT/server/src/net/crypt.rb

# TODO: Allow specify language
cp $APP_ROOT/server/src/constants/locale_constants.rb_sb $APP_ROOT/server/src/constants/locale_constants.rb_tcn
