## Unlight
# Copyright(c)2019 CPA
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

require 'rubygems'
require 'sequel'
require 'logger'
require 'db_config'

module Unlight
  # ============== DB関連定数 ==================
  #保存形式 :csv または:sqlite3,:mysql
  unless $SERVER_NAME
    $SERVER_NAME = "NOT_SV"
  end
  STORE_TYPE = (ENV['DB_ADAPTER'] || :sqlite3).to_sym
  # memcached server
  MEMCACHE_CONFIG = (ENV['MEMCACHED_HOST'] || 'localhost:11211')
  MEMCACHE_OPTIONS = {
    timeout: 1,
    namespace: 'unlight'
  }

  #mysql設定のデフォルト
  MYSQL_CONFIG =  {
    host: ENV['DB_HOST'] || 'db',
    user: ENV['DB_USER'] || 'unlight',
    password: ENV['DB_PASSWORD'] || 'unlight',
    database: ENV['DB_NAME'] || 'unlight_db',
    encoding: 'utf8',
    port: (ENV['DB_PORT'] || 3306).to_i,
    max_connections: (ENV['DB_POOL_SIZE'] || 5).to_i,
    loggers: Logger.new(STDOUT)
  }
end

