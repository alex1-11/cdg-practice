BALANCE = 'balance.txt'.freeze
DEFAULT_BALANCE = 100.0

GREETING = %(Hello and welcome to Royal bank of Stormwind!
To use ATM type the following commands
to the console and follow instructions:).freeze

TIP = %(  B - show current account balance,
  D - deposit extra money to the account,
  W - withdraw money from the account,
  Q - quit ATM.

Enter the command: ).freeze

COMMANDS = ['B', 'D', 'W', 'Q']

def ask_next
  puts 'Do you want anything else? Type in one of the options:'.freeze, TIP
end

def balance(account)
  puts "Current balance is #{account} golden units"
end

def deposit(account)
  print 'Enter amount you wish to deposit: '
  amount = 0.0
  until amount > 0
    amount = gets.to_f
    puts 'Amount should be positive number' if amount
  end 
end


def withdraw(account)
  
end

def quit(account)
  
end

# Main script, starts ATM with full functionality
def use_atm
  # Load up balance or use default size if not defined
  account = File.exist? BALANCE ? File.read(BALANCE).to_f : DEFAULT_BALANCE
  # Interact with user, give instructions
  puts GREETING, TIP
  # Ask user input, force to upcase 
  loop do
    command = gets.chomp.upcase
    # Update account balance varibale depending on command -- https://www.alanwsmith.com/posts/assigning-ruby-variables-with-a-case-statement--20en0nhdumt0
    account = case command
    when 'B'
      balance(account)
    when 'D'
      deposit(account)
    when 'W'
      withdraw(account)
    when 'Q'
      quit(account)
    else
      puts "Input error. No such command. Type one of these chars:\n", COMMANDS
    end
    ask_next
  end
end

# use_atm
