# Prints stuff in a file. Makes for a good testing thing.

require 'securerandom'

file = File.join(File.dirname(__FILE__), '../../log/crap')

loop do
  file = File.new(file, File::CREAT|File::RDWR, 0644)
  line_count = file.readlines.size + 1
  file_size = file.size

  file.truncate(0) and redo if line_count > 999

  file.write("#{line_count} - #{file_size} - #{SecureRandom.hex(rand(100))}\n")
  file.close

  sleep 1
end
