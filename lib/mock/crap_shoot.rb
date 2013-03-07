# Prints stuff in a file.

require 'securerandom'

file = File.join(File.dirname(__FILE__), '../../log/crap')

(1..10000).each do
  file = File.new(file, File::CREAT|File::RDWR, 0644)
  line_count = file.readlines.size + 1
  file_size = file.size

  file.truncate(0) and redo if line_count > 999

  file.write("#{line_count} - #{file_size} - #{SecureRandom.hex(rand(100))}\n")
  file.close
end
