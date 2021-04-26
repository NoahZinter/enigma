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
    cipher[:key] = read_key
    cipher[:date] = date
    cipher
  end

  def decrypt(message, key, date = format_date)
    key_conditional(key)
    offset_keys(date)
    decipher = {}
    decipher[:decryption] = decode_message(message)
    decipher[:key] = key
    decipher[:date] = date
    decipher
  end

  def normalize_key
    string_key = @key.map { |number| number.to_s }
    string_key.map do |string|
      if string.length < 2
        string.insert(0, '0')
      else string
      end
    end.join.split('')
  end

  def read_key
    total = normalize_key
    indices_to_reject = [2, 4, 6]
    total.reject.each_with_index do |number, index|
      indices_to_reject.include?(index)
    end.join
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
    shortened_year = date_array.last.strip[-2, 2]
    date_array[-1] = shortened_year
    date_array[0], date_array[1] = date_array[1], date_array[0]
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
      changed.rotate!(offset)
      changed.first
    else
      changed.first
    end
  end

  def decode_letter(letter, offset)
    encode_letter(letter, offset * -1)
  end

  def decode_message(message)
    offset = generate_total_offset
    elements = message.downcase.split('')
    repeat = elements.length
    decoded = []
      repeat.times do
        decoded << decode_letter(elements.first, offset.first)
        elements.rotate!(1)
        offset.rotate!(1)
      end
    decoded.join
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

  def generate_key(key)
    total_key = key.split('')
    assign_keys(total_key)
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
