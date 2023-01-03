require 'rack'
require 'pry'

require './atm'

# A Rack app to handle HTTP requests
class App
  def call(env)
    req = Rack::Request.new(env)

    # Packs params from GET request into array of hashes
    params = req.query_string.split('&').map { |pair| pair.split('=') }.to_h

    # Check params in console
    puts params

    case req.path
    when '/'
      [200, { 'Content-Type' => 'text/html' }, File.readlines('./index.html')]
    when '/atm'
      result = atm_controller(params)
      [200, { 'Content-Type' => 'text/html' }, ["<h1>#{result}</h1>", "<a href='/'>Home</a>"]]
    else
      [404, { 'Content-Type' => 'text/html' }, ['<h1>404</h1>', '<p>Page not found. Try to check your request.</p>']]
    end
  end

  def atm_controller(params)
    atm = Atm.new

    case params['action']
    when 'B'
      atm.balance
    when 'D'
      atm.deposit
    when 'W'
      atm.withdraw
    when 'Q'
      atm.quit
    end

    atm.balance
  end
end
