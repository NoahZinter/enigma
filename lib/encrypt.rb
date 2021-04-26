require './lib/enigma'
require 'date'

message_handle = File.open(ARGV[0], 'r')
incoming_text = message_handle.read
message_handle.close

write_handle = File.open(ARGV[1], 'w')

enigma = Enigma.new
encrypted_message = enigma.encrypt(incoming_text)

key = encrypted_message[:key]
date = encrypted_message[:date]
message = encrypted_message[:encryption]

write_handle.write(encrypted_message, message)
write_handle.close

puts "Created #{ARGV[1]} with key #{key} and date #{date}"
