BALANCE = 'balance.txt'.freeze
DEFAULT_BALANCE = 100.0

GREETING = "
=============================================
Hello and welcome to Royal bank of Stormwind!
=============================================".freeze

TIP = %(  To proceed type-in one of the options:
  B - show current account balance,
  D - deposit extra money to the account,
  W - withdraw money from the account,
  Q - quit ATM.

Enter the command: ).freeze

COMMANDS = ['B', 'D', 'W', 'Q'].map(&:freeze)

# Verify if input is positive and Float type -- https://stackoverflow.com/a/31411319/20260711
def input_float
  amount = Float(gets.chomp)
  puts
  if amount <= 0
    puts 'ERROR! Amount should be a POSITIVE number! <<<<<<<<<<<<<<<<<'
    amount = 0
  end
  amount
rescue ArgumentError
  puts 'ERROR! Amount should be a NUMBER! Floating point is allowed. <<<<<<<<<<<<<<<<<'
  0
end

class Atm
  # Starts ATM with full functionality
  def initialize
    # Load up balance or use default size if not defined
    @account = File.exist?(BALANCE) ? File.read(BALANCE).to_f : DEFAULT_BALANCE
  end

  # Puts user's account balance at console
  def balance
    puts '__________________________________________',
         '',
         "Current balance is #{@account} golden units",
         '__________________________________________'
  end

  # Asks for amount and increses the account balance
  def deposit
    print 'Enter amount you wish to deposit: '
    amount = input_float
    puts ''
    puts 'Deposit successfully completed.' if amount > 0
    @account += amount
  end

  # Asks for amount to withdraw, checks if it's possible and updates account
  def withdraw
    print 'Enter amount you wish to withdraw: '
    amount = input_float
    puts ''
    # Make sure user has sufficient balance
    if amount > @account
      puts 'ERROR! Balance insufficient! <<<<<<<<<<<<<<<<<'
      amount = 0
    end
    puts 'Withdrawal successfully completed.' if amount != 0
    @account -= amount
  end

  # Saves current account balance to the file and closes it
  def quit
    puts 'Closing session...'
    File.write(BALANCE, @account)
    puts '',
         '===================================================',
         'FUNDS ARE SAFU!',
         'Thanks for using Royal bank of Stormwind! Good bye!',
         '==================================================='
  end
end

# Asks user for command input and triggers the action ATM should take
class CommandController
  def initialize
    # Interact with user, give starting instructions
    puts GREETING, TIP
    loop do
      # Ask user input, force to upcase
      command = gets.chomp.upcase
      puts ''
      # Update account balance varibale depending on command -- https://www.alanwsmith.com/posts/assigning-ruby-variables-with-a-case-statement--20en0nhdumt0
      case command
      when 'B'
        Atm.balance
      when 'D'
        Atm.deposit
      when 'W'
        Atm.withdraw
      when 'Q'
        Atm.quit
        break
      else
        puts 'ERROR: Input error! No such command. <<<<<<<<<<<<<<<<<'
      end
    end
  end
end

Atm.new
CommandController.new
