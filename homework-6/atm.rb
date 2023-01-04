BALANCE = 'balance.txt'
DEFAULT_BALANCE = 100.0

# The ATM app. Initialize an instance as a variable to load up balance value.
class Atm
  attr_reader :account

  # Starts ATM, loads up balance or uses default size if not defined
  def initialize
    @account = File.exist?(BALANCE) ? File.read(BALANCE).to_f : DEFAULT_BALANCE
  end

  # Simply returns user's account balance
  def balance
    @account
  end

  # Checks if float from user input is correct
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
    save_balance
  end

  # Validates amount to withdraw, updates account balance if ok
  def withdraw(amount)
    amount = validate_float(amount)

    # Make sure user has sufficient balance
    if amount > @account
      puts 'ERROR! Balance insufficient!'
      amount = 0
    end

    puts 'Withdrawal successfully completed.' if amount != 0
    @account -= amount
    save_balance
  end

  # Saves current account balance to the file, closes file, returns balance
  def save_balance
    File.write(BALANCE, @account)
    @account
  end

  private :validate_float
end
