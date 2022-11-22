age = gets

def message(age)
    age < 18 ? "You`re too young" : "Welcome!"
end

puts message(18)
puts message(14)
puts message(22)