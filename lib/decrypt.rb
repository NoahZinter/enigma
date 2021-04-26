require './lib/enigma'
require 'date'

handle = File.open(ARGV[0], 'r')
incoming_text = handle.read
handle.close
split_text = incoming_text.split("}")
encryption = split_text[1].chop

# encryption = split_text[2].delete!(["\n", ":key"])
# require 'pry'; binding.pry
# encrypted_hash = eval(incoming_text)
# encryption = encrypted_hash[:encryption]

decrypt_handle = File.open(ARGV[1], 'w')

key = ARGV[2].to_s
date = ARGV[3].to_s

enigma = Enigma.new
decrypted_message = enigma.decrypt(encryption, key, date)

puts "Created #{ARGV[1]} with key #{key} and date #{date}"

decrypt_handle.write(decrypted_message)
decrypt_handle.close
