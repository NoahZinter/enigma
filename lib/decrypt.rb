require './lib/enigma'
require 'date'

message_handle = File.open(ARGV[0], 'r')
incoming_text = message_handle.read
message_handle.close

split_text = incoming_text.split("}")
encryption = split_text[1].chop

decrypt_handle = File.open(ARGV[1], 'w')
key = ARGV[2].to_s
date = ARGV[3].to_s

enigma = Enigma.new

decrypted_message = enigma.decrypt(encryption, key, date)
decrypt_handle.write(decrypted_message)
decrypt_handle.close

puts "Created #{ARGV[1]} with key #{key} and date #{date}"
