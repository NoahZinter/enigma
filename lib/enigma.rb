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
    key_a = total_key[0..1].join.to_i
    key_b = total_key[1..2].join.to_i
    key_c = total_key[2..3].join.to_i
    key_d = total_key[3..4].join.to_i
    key_array.push(key_a,key_b,key_c,key_d)
    key_array
  end

  def generate_offset(date)
    squared = (date.to_i ** 2).to_s
    squared_as_arry = squared.split('')
    offset_keys = squared_as_arry.last(4)
    offset_keys.map do |key|
      key.to_i
    end
  end
end