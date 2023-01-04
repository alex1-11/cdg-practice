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
    when '/balance'
      params['action'] = 'B'
      result = atm_controller(params)
      [200, { 'Content-Type' => 'text/html' }, ["<h3>#{result}</h3>",
                                                "<br><a href='/'>Home</a>"]]
    when '/deposit'
      params['action'] = 'D'
      result = atm_controller(params)
      [200, { 'Content-Type' => 'text/html' }, ["<h3>#{result}</h3>",
                                                "<br><a href='/'>Home</a>"]]
    when '/withdraw'
      params['action'] = 'W'
      result = atm_controller(params)
      [200, { 'Content-Type' => 'text/html' }, ["<h3>#{result}</h3>",
                                                "<br><a href='/'>Home</a>"]]
    else
      [404, { 'Content-Type' => 'text/html' }, ['<h1>404</h1>',
                                                '<p>Page not found. Try to check your request.</p>',
                                                "<br><a href='/'>Home</a>"]]
    end
  end

  def atm_controller(params)
    atm = Atm.new
    case params['action']
    when 'B'
      "Current balance is #{atm.balance} gold."
    when 'D'
      "Previous balance was #{atm.balance} gold.<br>"\
      "New balance after deposit attempt is #{atm.deposit(params['value'])} gold."
    when 'W'
      "Previous balance was #{atm.balance} gold.<br>"\
      "New balance after withdraw attempt is #{atm.withdraw(params['value'])} gold."
    end
  end
end
