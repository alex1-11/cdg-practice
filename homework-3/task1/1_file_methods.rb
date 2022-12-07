FILENAME = 'sample.txt'.freeze
BUFFER = 'buffer.txt'.freeze

# Puts all the lines from file
def index
  print File.read(FILENAME)
end

# Finds line with under given id puts and returns it
def find(id)
  data = File.readlines(FILENAME).map(&:chomp)
  if data[id].nil?
    puts 'No data for this id'
  else
    puts data[id]
    data [id]
  end
end

# Puts all the lines that have a pattern as substring,
# collects them into array, prints lines and returns array
def where(pattern)
  result = []
  data = File.readlines(FILENAME).map(&:chomp)
  data.each do |str|
    if str.include? pattern
      puts str
      result.push(str)
    end
  end
  result
end

def update(id, text)
  buffer = File.open(BUFFER, 'w')
  File.foreach(FILENAME).with_index do |str, index|
    buffer.puts(index == id ? text : str)
  end
  buffer.close
  File.write(FILENAME, File.read(BUFFER))
  File.delete(BUFFER) if File.exist?(BUFFER)
end

def delete(id)
  buffer = File.open(BUFFER, 'w')
  File.foreach(FILENAME).with_index do |str, index|
    buffer.print(index == id ? '' : str)
  end
  buffer.close
  File.write(FILENAME, File.read(BUFFER))
  File.delete(BUFFER) if File.exist?(BUFFER)
end

def create(name)
  File.write(FILENAME, "#{name}\n", mode: 'a')
end
