require 'date'
require './lib/enigma'

describe Enigma do
  describe '#initialize' do
    it 'exists' do
      enigma = Enigma.new
      expect(enigma).is_a? Enigma
    end

    it 'has a letters array' do
      enigma = Enigma.new
      expect(enigma.letters).to eq(["a", "b", "c",
      "d", "e", "f", "g", "h", "i", "j", "k", "l",
      "m", "n", "o", "p", "q", "r", "s", "t", "u",
      "v", "w", "x", "y", "z", " "])
    end
  end

  # describe '#encrypt' do
  #   it 'returns a hash of encryption, key, date' do
  #     enigma = Enigma.new
  #     expect(enigma.encrypt('hello world', '02715', '040895')).to eq (
  #     {
  #       encryption: "keder ohulw",
  #       key: "02715",
  #       date: "040895"
  #     })
  #   end
  # end
end