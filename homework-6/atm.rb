BALANCE = 'balance.txt'
DEFAULT_BALANCE = 100.0

GREETING = "
=============================================
Hello and welcome to Royal bank of Stormwind!
============================================="

TIP = %(  To proceed type-in one of the options:
  B - show current account balance,
  D - deposit extra money to the account,
  W - withdraw money from the account,
  Q - quit ATM.

Enter the command: )

# The ATM app. Initialize an instance as a variable to load up balance value.
# Then use init for CLI to interact.
class Atm
  attr_reader :account

  # Starts ATM, loads up balance or uses default size if not defined
  def initialize
    @account = File.exist?(BALANCE) ? File.read(BALANCE).to_f : DEFAULT_BALANCE
  end

  # Starts CLI to interact with ATM.
  # Asks user for command input and triggers the action ATM should take.
  def init
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
        balance
      when 'D'
        deposit
        balance
      when 'W'
        withdraw
        balance
      when 'Q'
        quit
        break
      else
        puts 'ERROR: Input error! No such command. <<<<<<<<<<<<<<<<<'
      end
    end
  end

  # Puts user's account balance at console
  def balance
    puts '__________________________________________',
         '',
         "Current balance is #{@account} golden units",
         '__________________________________________'
    @account
  end

  # Gets correct float from user input
  def validate_float(amount)
    amount = Float(amount)

    # Verify if input is positive
    if amount <= 0
      puts 'ERROR! Amount should be a POSITIVE number!'
      amount = 0
    end
    amount

  # Handles error and puts it to console if input is not Float type -- https://stackoverflow.com/a/31411319/20260711
  rescue ArgumentError
    puts 'ERROR! Amount should be a NUMBER! Floating point is allowed.'
    # Returns zero if input was invalid type
    0
  end

  # Increases the account balance by given amount after validation
  def deposit(amount)
    amount = validate_float(amount)
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

  private :validate_float
end

# atm = Atm.new
# atm.init
