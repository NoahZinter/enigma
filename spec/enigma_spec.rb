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
      enigma.generate_key

      expect(enigma.generate_5).is_a? String
      expect(enigma.generate_5.length).to eq 5
    end
  end

  describe '#generate_key' do
    it 'splits a 5 character string into 4 keys' do
      enigma = Enigma.new
      allow(enigma).to receive(:generate_5) { '12345' }

      expect(enigma.generate_key).to eq ([12, 23, 34, 45])
    end
  end

  describe '#offset_keys' do
    it 'generates 4 offset keys' do
      enigma = Enigma.new

      expect(enigma.offset_keys('040895')).to eq ([1, 0, 2, 5])
    end
  end

  describe '#generate_total_offset' do
    it 'combines generate_key and offset_keys into 4 keys' do
      enigma = Enigma.new
      allow(enigma).to receive(:generate_5) {'02715'}
      enigma.generate_key
      enigma.offset_keys('040895')

      expect(enigma.generate_total_offset).to eq ([3, 27, 73, 20])
    end
  end

  describe '#rotate_letters' do
    it 'rotates the letters array to begin with given letter' do
      enigma = Enigma.new
      expect(enigma.rotate_letters('h').first).to eq 'h'
      expect(enigma.rotate_letters('z').first).to eq 'z'
    end
  end

  describe '#encode_letter' do
    it 'changes the letter according to total offset' do
      enigma = Enigma.new
      allow(enigma).to receive(:generate_5) {'02715'}
      enigma.generate_key
      enigma.offset_keys('040895')

      expect(enigma.encode_letter('h', 3)).to eq 'k'
      expect(enigma.encode_letter('e', 27)).to eq 'e'
    end
  end

  describe '#encrypt' do
    xit 'returns a hash of encryption, key, date' do
      enigma = Enigma.new
      allow(enigma).to receive(:generate_key) {'02715'}
      expect(enigma.encrypt('hello world', '02715', '040895')).to eq (
      {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      })
    end
  end
end