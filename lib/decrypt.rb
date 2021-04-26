require './lib/enigma'
require 'date'
require 'yaml'

handle = File.open(ARGV[0], 'r')
incoming_text = handle.read
handle.close
encrypted_hash = eval(incoming_text)
encryption = encrypted_hash[:encryption]

decrypt_handle = File.open(ARGV[1], 'w')

key = ARGV[2].to_s
date = ARGV[3].to_s

enigma = Enigma.new
decrypted_message = enigma.decrypt(encryption, key, date)

puts "Created #{ARGV[1]} with key #{key} and date #{date}"

decrypt_handle.write(decrypted_message)
decrypt_handle.close