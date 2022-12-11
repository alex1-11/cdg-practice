def get_word
  print 'Type a word > '
  gets.chomp
end

def cspower(word)
  if word.upcase.end_with?('CS')
    2**word.length
  else
    word.reverse
  end
end

cspower(get_word)
