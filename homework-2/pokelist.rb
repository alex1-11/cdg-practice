def getpoke_qty
  loop do
    print 'How many pokemons to add? > '
    qty = gets.chomp.to_i
    if qty.class == Integer && qty > 0
      return qty
    end
    puts 'Error! Number must be a positive integer.'
  end
end

def add_poke
  poke = {}
  puts 'Adding new pokemon...'
  loop do
    print 'Name > '
    name = gets.chomp
    if name.empty?
      puts 'Error! Name can`t be blank!'
    else
      poke[:name] = name
      break
    end
  end
  loop do
    print 'Color > '
    color = gets.chomp
    if color.empty?
      puts 'Error! Color can`t be blank! Write "transparent" ' +
           'if pokemon doesn`t have any color at all :)'
    else
      poke[:color] = color
      break
    end
  end
  poke
end
