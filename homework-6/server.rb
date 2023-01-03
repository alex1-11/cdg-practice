require 'socket'
require 'rack'
require './atm'
require './app'

server = TCPServer.new('0.0.0.0', 3000)

app = App.new

while (connection = server.accept)
  request = connection.gets
  method, full_path = request.split(' ')
  path = full_path.split('?')[0]

  status, headers, body = app.call({
                                     REQUEST_METHOD: method,
                                     PATH_INFO: path,
                                     QUERY_STRING: full_path.split('?')[1]
                                   })

  connection.print("HTTP/1.1 #{status}\r\n")
  headers.each do |key, value|
    connection.print("#{key}: #{value}\r\n")
  end
  connection.print "\r\n"
  body.each do |part|
    connection.print(part)
  end
  connection.close
end
