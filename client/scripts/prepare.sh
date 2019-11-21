#!/usr/bin/env sh

# Prepare server for dump data
cp $SERVER_ROOT/src/server_ip.rb_orig $SERVER_ROOT/src/server_ip.rb
cp $SERVER_ROOT/src/net/crypt.rb_orig $SERVER_ROOT/src/net/crypt.rb
cp $SERVER_ROOT/src/constants/locale_constants.rb_sb $SERVER_ROOT/src/constants/locale_constants.rb
cp $SERVER_ROOT/src/constants/locale_constants.rb_sb $SERVER_ROOT/src/constants/locale_constants.rb_tcn

# Initialize
cp $CLIENT_ROOT/src/Unlight-config_sandbox.xml $CLIENT_ROOT/src/Unlight-config.xml
