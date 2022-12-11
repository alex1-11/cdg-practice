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

# The ATM app. Initialize an instance as a variable.
# Then initialize a CommandController for interaction.
class Atm
  # Starts ATM, loads up balance or uses default size if not defined
  def initialize
    @account = File.exist?(BALANCE) ? File.read(BALANCE).to_f : DEFAULT_BALANCE
  end

  # Puts user's account balance at console
  def balance
    puts '__________________________________________',
         '',
         "Current balance is #{@account} golden units",
         '__________________________________________'
  end

  # Gets correct float from user input
  def input_float
    amount = Float(gets.chomp)
    puts

    # Verify if input is positive
    if amount <= 0
      puts 'ERROR! Amount should be a POSITIVE number! <<<<<<<<<<<<<<<<<'
      amount = 0
    end
    amount

  # Handles error and puts it to console if input is not Float type -- https://stackoverflow.com/a/31411319/20260711
  rescue ArgumentError
    puts 'ERROR! Amount should be a NUMBER! Floating point is allowed. <<<<<<<<<<<<<<<<<'
    # Returns zero if input was invalid type
    0
  end

  # Asks for amount to deposit and increases the account balance
  def deposit
    print 'Enter amount you wish to deposit: '
    amount = input_float
    puts ''
    puts 'Deposit successfully completed.' if amount.positive?
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

  private :input_float
end

# Asks user for command input and triggers the action ATM should take
class CommandController
  def initialize(atm)
    # Interact with user, give starting instructions
    puts GREETING

    loop do
      # Ask user input, force to upcase
      puts TIP
      command = gets.chomp.upcase
      puts ''

      # Execute the given command depending on preset
      case command
      when 'B'
        atm.balance
      when 'D'
        atm.deposit
        atm.balance
      when 'W'
        atm.withdraw
        atm.balance
      when 'Q'
        atm.quit
        break
      else
        puts 'ERROR: Input error! No such command. <<<<<<<<<<<<<<<<<'
      end
    end
  end
end

atm = Atm.new
CommandController.new(atm)
