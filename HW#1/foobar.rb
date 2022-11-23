def foobar(int1, int2)
  int1 = int1.to_i
  int2 = int2.to_i
  if int1 == 20
    int2
  elsif int2 == 20
    int1
  else
    int1 + int2
  end
end

print "Enter num1: "
input1 = gets.to_i
print "Enter num2: "
input2 = gets.to_i
puts "foobar(#{input1}, #{input2}) returns #{foobar(input1, input2)}"