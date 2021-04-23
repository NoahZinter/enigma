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

      expect(enigma.generate_5).is_a? String
      expect(enigma.generate_5.length).to eq 5
    end
  end

  describe '#generate_key' do
    it 'splits a 5 character string into 4 keys' do
      enigma = Enigma.new

      expect(enigma.generate_key('12345')).to eq ([12, 23, 34, 45])
    end
  end

  describe '#assign_keys' do
    it 'splits a 5 character string into 4 keys' do
      enigma = Enigma.new
      total_key = ['1','2','3','4','5']
      expect(enigma.assign_keys(total_key)).to eq ([12, 23, 34, 45])
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
      enigma.generate_key('02715')
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
      enigma.generate_key('02715')
      enigma.offset_keys('040895')

      expect(enigma.encode_letter('h', 3)).to eq 'k'
      expect(enigma.encode_letter('e', 27)).to eq 'e'
    end

    it 'will move to the next letter if it lands on a space' do
      enigma = Enigma.new
      enigma.generate_key('02715')
      enigma.offset_keys('040895')

      expect(enigma.encode_letter('z', 1)).to eq 'a'
    end

    it 'will return any character not in @letters array' do
      enigma = Enigma.new
      enigma.generate_key('02715')
      enigma.offset_keys('040895')

      expect(enigma.encode_letter('!', 23)).to eq '!'
      expect(enigma.encode_letter('?', 12)).to eq '?'
    end

    it 'will return a space if given a space' do
      enigma = Enigma.new
      enigma.generate_key('02715')
      enigma.offset_keys('040895')

      expect(enigma.encode_letter(' ', 18)).to eq ' '
    end
  end

  describe '#encode_message' do
    it 'encodes a message' do
      enigma = Enigma.new
      enigma.generate_key('02715')
      enigma.offset_keys('040895')
      message = 'hello world'

      expect(enigma.encode_message(message)).to eq 'keder ohulw'
    end

    it 'can handle incorrect inputs' do
      enigma = Enigma.new
      enigma.generate_key('02715')
      enigma.offset_keys('040895')
      message = 'HeLlO WoRlD!&?'

      expect(enigma.encode_message(message)).to eq 'keder ohulw!&?'
    end
  end

  describe '#encrypt' do
    it 'returns a hash of encryption, key, date' do
      enigma = Enigma.new

      expected = (
      {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      })
      expect(enigma.encrypt('hello world', '02715', '040895')).to eq expected
    end

    it 'can return a full hash when only given a message' do
      enigma = Enigma.new
      expected = enigma.encrypt('hello')
      today = Date.today.to_s

      expect(expected[:key]).is_a? String
      expect(expected[:date]).to eq today
    end
  end
end