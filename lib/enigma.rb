class Enigma
  attr_reader :letters, :key, :offset
  def initialize
    @letters = ('a'..'z').to_a << ' '
    @key = key
    @offset = offset
  end

  def encrypt(message, key = nil, date = Date.today.to_s)
    if key == nil
      key = generate_5
      generate_key(key)
    else 
      generate_key(key)
    end
    offset_keys(date)
    cipher = Hash.new
    cipher[:encryption] = encode_message(message)
    cipher[:key] = key
    cipher[:date] = date
    cipher
  end

  def rotate_letters(letter)
    rotation = @letters.find_index do |element|
                  element == letter
                end
    oriented = @letters.rotate(rotation)
    oriented
  end

  def encode_letter(letter, offset)
    return letter if !@letters.include?(letter) || letter == ' '
    starting = rotate_letters(letter)
    changed = starting.rotate(offset)
    if changed.first == " "
      changed.rotate!(1)
      changed.first
    else
      changed.first
    end
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
    key_array.push(key_a,key_b,key_c,key_d)
    @key = key_array
  end

  def generate_key(key = nil)
    if key == nil 
      key = generate_5
      total_key = key.split('')
    else 
      total_key = key.split('')
    end
    assign_keys(total_key)
  end

  def offset_keys(date)
    squared = (date.to_i ** 2).to_s
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
