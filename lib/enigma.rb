class Enigma
  attr_reader :letters
  def initialize
    @letters = ('a'..'z').to_a << ' '
  end

  def encrypt(string, key, date)
    cipher = Hash.new
    cipher[:encryption] = string
    cipher[:key] = key
    cipher[:date] = date
    cipher
  end
end