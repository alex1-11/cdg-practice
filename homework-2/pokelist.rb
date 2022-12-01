def getpoke_qty
  loop do
    print 'How many pokemons to add? > '
    qty = gets.chomp.to_i
    if qty.class == Integer && qty > 0
      return qty
    end
    puts "Error! Number must be a positive integer."
  end
end
