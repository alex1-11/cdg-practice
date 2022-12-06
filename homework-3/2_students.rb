FILENAME = 'students.txt'.freeze
RESULTS = 'results.txt'.freeze

def choose_students
  # Read file
  data = File.readlines(FILENAME).map(&:chomp)
  # Loop through students' list
  loop do
    # Ask for age input
    print 'Enter student`s age to search for: '
    asked_age = gets.chomp
    # Finish early if user input exit code '-1'
    break if asked_age == '-1'
    # Find exact age match
    data.each do |line|
      cells = line.split
      if cells[2] == asked_age
        # Write (append) found student to file results.txt
        File.write(RESULTS, "#{line}\n", mode: "a")
        # Erase the line value (don't delete element during loop)
        line = nil
      end
    end
    # Get rid of erased lines
    data.compact!
    # Finish if all the students were written to results.txt
    break if data.empty?
    # Loop back for age input otherwise
  end
end

choose_students