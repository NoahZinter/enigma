class Enigma
  attr_reader :letters
  def initialize
    @letters = ('a'..'z').to_a << ' '
  end

  def encrypt(string, key = split_keys, date = Date.today)
    cipher = Hash.new
    cipher[:encryption] = encode_string(string, key, date)
    cipher[:key] = key
    cipher[:date] = date
    cipher
  end

  def encode_string(string, key, date)

  end

  def generate_5
    5.times.map{rand(5)}.join
  end

  def split_keys
    total_key = generate_5.split('')
    key_array = []
    key_a = total_key[0..1].join
    key_b = total_key[1..2].join
    key_c = total_key[2..3].join
    key_d = total_key[3..4].join
    key_array.push(key_a,key_b,key_c,key_d)
    key_array
  end

  def generate_offset(date)

  end
end