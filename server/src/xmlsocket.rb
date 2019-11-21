# frozen_string_literal: true

require 'socket'
require 'logger'

SERVER_LOG = Logger.new('/dev/stdout')
RESPONSE = File.read('/app/server/script/Perl_xinetd/flashpolicy.xml')

server = TCPServer.new 11999

SERVER_LOG.info('XMLSocket server is starting...')

loop do
  client = server.accept
  Thread.new do
    SERVER_LOG.info("Client #{client.addr&.last} is connected")
    client.write(RESPONSE)
    client.close
  end
end
