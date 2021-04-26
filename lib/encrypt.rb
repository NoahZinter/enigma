require './lib/enigma'
require 'date'

handle = File.open(ARGV[0], 'r')
incoming_text = handle.read
handle.close

write_handle = File.open(ARGV[1], 'w')

enigma = Enigma.new
encrypted_message = enigma.encrypt(incoming_text)

key = encrypted_message[:key]
date = encrypted_message[:date]
puts "Created #{ARGV[1]} with key #{key} and date #{date}"

write_handle.write(encrypted_message)
write_handle.close
