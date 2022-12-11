def foobar(num1, num2)
  if num1 == 20
    num2
  elsif num2 == 20
    num1
  else
    num1 + num2
  end
end

print 'Enter num1: '
input1 = gets.to_i
print 'Enter num2: '
input2 = gets.to_i
puts "foobar(#{input1}, #{input2}) returns #{foobar(input1, input2)}"
