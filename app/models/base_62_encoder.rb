# encoding algorithm based on http://refactormycode.com/codes/125-base-62-encoding
# decoding is my own

class Base62Encoder
  CHARS = [('0'..'9'),('a'..'z'),('A'..'Z')].map(&:to_a).flatten
  BASE = CHARS.length

  def self.encode(integer)
    unless integer.is_a? Integer
      raise ArgumentError, "Can only encode an integer"
    end
    if integer < 1
      raise ArgumentError, "Cannot encode a non-positive integer"
    end
    s = ''
    while integer > 0
      s << CHARS[ integer % BASE ]
      integer /= BASE
    end
    s.reverse
  end

  def self.decode(string)
    unless string.is_a? String
      raise ArgumentError, "Can only decode a string"
    end
    if (string.each_char.to_a - CHARS).any?
      raise ArgumentError, "#{string} is not a valid base-#{BASE} string."
    end
    (string.reverse.each_char.each_with_index.map do |char, position|
      CHARS.index(char) * (BASE**(position))
    end).sum
  end
end
