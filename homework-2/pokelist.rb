def getpoke_qty
  loop do
    print 'How many pokemons to add? > '
    qty = gets.chomp.to_i
    return qty if qty.positive?

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
      puts 'Error! Color can`t be blank! Write "transparent" ' \
           'if pokemon doesn`t have any color at all :)'
    else
      poke[:color] = color
      break
    end
  end

  poke
end

def pack_pokes(qty)
  pokelist = []
  i = 0

  qty.times do
    i += 1
    puts "##{i}"
    pokelist.append(add_poke)
  end

  pokelist
end

pokelist = pack_pokes(getpoke_qty)
puts "===\nHere is your list of pokemons:\n#{pokelist.inspect}"
