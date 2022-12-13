def greeting
  print "What's your frist name? > "
  firstname = gets.chomp

  print "What's your last name? > "
  lastname = gets.chomp

  print 'How old are you? > '
  age = gets.to_i

  if age < 18
    puts "Hello, #{firstname} #{lastname}. You are younger than 18, but " \
         'starting to learn coding is never too early.'
  else
    puts "Hello, #{firstname} #{lastname}. It's a great time to start coding!"
  end
end

greeting
