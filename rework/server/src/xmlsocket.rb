# frozen_string_literal: true

require 'socket'

server = TCPServer.new 11999
response = File.read('/app/server/script/Perl_xinetd/flashpolicy.xml')

loop do
  client = server.accept
  Thread.new do
    client.write(response)
    client.close
  end
end
