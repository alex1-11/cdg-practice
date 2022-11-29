COMMAND = { quit: "q", withdraw: 'w' }

loop do 
  command = get.chomp.to_sym
  case command
  when COMMAND[:quit]
    break
  when COMMAND[:withdraw]
    balance -= gets.to_f
  end
end
