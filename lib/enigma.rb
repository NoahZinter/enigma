class Enigma
  attr_reader :letters, :key, :offset
  def initialize
    @letters = ('a'..'z').to_a << ' '
    @key = key
    @offset = offset
  end

  def encrypt(message, key = nil, date = format_date)
    key_conditional(key)
    offset_keys(date)
    cipher = {}
    cipher[:encryption] = encode_message(message)
    cipher[:key] = key
    cipher[:date] = date
    cipher
  end

  def decrypt(message, key = nil, date = format_date)
    key_conditional(key)
    offset_keys(date)
    decipher = {}
    decipher[:decryption] = decode_message(message)
    decipher[:key] = key
    decipher[:date] = date
    decipher
  end

  def key_conditional(key)
    if key.nil?
      key = generate_5
      generate_key(key)
    else
      generate_key(key)
    end
  end

  def format_date
    date = Date.today.to_s
    date_array = date.split('-').rotate(1)
    shortened_year = date_array.last.strip[-2,2]
    date_array[-1] = shortened_year
    formatted_date = date_array.join
    formatted_date
  end

  def rotate_letters(letter)
    rotation = @letters.find_index { |element| element == letter }
    oriented = @letters.rotate(rotation)
    oriented
  end

  def encode_letter(letter, offset)
    return letter if !@letters.include?(letter) || letter == ' '
    starting = rotate_letters(letter)
    changed = starting.rotate(offset)
    if changed.first == ' '
      changed.rotate!(1)
      changed.first
    else
      changed.first
    end
  end

  def decode_letter(letter, offset)
    return letter if !@letters.include?(letter) || letter == ' '
    offset = (offset * -1)
    starting = rotate_letters(letter)
    changed = starting.rotate(offset)
    if changed.first == ' '
      changed.rotate!(-1)
      changed.first
    else
      changed.first
    end
  end

  def decode_message(message)
    offset = generate_total_offset
    elements = message.downcase.split('')
    repeat = elements.length
    encoded = []
      repeat.times do
        encoded << decode_letter(elements.first, offset.first)
        elements.rotate!(1)
        offset.rotate!(1)
      end
    encoded.join
  end

  def encode_message(message)
    offset = generate_total_offset
    elements = message.downcase.split('')
    repeat = elements.length
    encoded = []
      repeat.times do
        encoded << encode_letter(elements.first, offset.first)
        elements.rotate!(1)
        offset.rotate!(1)
      end
    encoded.join
  end

  def generate_5
    5.times.map{rand(5)}.join
  end

  def assign_keys(total_key)
    key_array = []
    key_a = total_key[0..1].join.to_i
    key_b = total_key[1..2].join.to_i
    key_c = total_key[2..3].join.to_i
    key_d = total_key[3..4].join.to_i
    key_array.push(key_a, key_b, key_c, key_d)
    @key = key_array
  end

  def generate_key(key)
    total_key = key.split('')
    assign_keys(total_key)
  end

  def offset_keys(date)
    squared = (date.to_i**2).to_s
    squared_as_arry = squared.split('')
    offset_keys = squared_as_arry.last(4)
    @offset = offset_keys.map do |key|
      key.to_i
    end
  end

  def generate_total_offset
    @key.zip(@offset).map do |array|
      array.sum
    end
  end
end
