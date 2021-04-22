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

  describe '#generate_5' do
    it 'generates a random 5 digit number' do
      enigma = Enigma.new
      enigma.generate_5
      enigma.split_keys
      expect(enigma.generate_5).is_a? String
      expect(enigma.generate_5.length).to eq 5
    end
  end

  describe '#split_keys' do
    it 'splits a 5 character string into 4 keys' do
      enigma = Enigma.new
      allow(enigma).to receive(:generate_5) { '12345' }

      expect(enigma.split_keys).to eq (['12', '23', '34', '45'])
    end
  end


  describe '#encrypt' do
    xit 'returns a hash of encryption, key, date' do
      enigma = Enigma.new
      # allow(enigma).to_receive(:generate_key).and return(02715)
      expect(enigma.encrypt('hello world', '02715', '040895')).to eq (
      {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      })
    end
  end
end