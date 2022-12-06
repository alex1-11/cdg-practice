FILENAME = 'students.txt'

def choose_students
  # Read file
  data = File.readlines(FILENAME).map(&:chomp)
  # Ask for age input
  asked_age = gets.to_i
  # Find exact age match
  def pick_by_age(age)
  end
  # Write (append) found student to file results.txt
  # Loop back for age input
  # Add end conditions
  # If all students were written to results.txt
  # If user input is -1
end