require 'test_helper'

class Base62EncoderTest < ActiveSupport::TestCase
  test "encode should return the proper base-62 encoded string" do
    test_cases.each do |integer, base62|
      assert_equal base62, Base62Encoder.encode(integer), "expected base 62 to be #{base62.inspect} for integer #{integer}"

    end
  end

  test "decode should return the proper base-10 integer" do
    test_cases.each do |integer, base62|
      assert_equal integer, Base62Encoder.decode(base62), "expected base 10 #{integer} for base 62 #{base62.inspect}"
    end
  end

  test "decode does not encode non-positive integers" do
    [-1000, -1, 0].each do |bad_integer|
      assert_raise ArgumentError do
        Base62Encoder.encode bad_integer
      end
    end
  end

  test "encode does not encode strings or floats" do
    ['1', 1.1].each do |bad_argument|
      assert_raise ArgumentError do
        Base62Encoder.encode bad_argument
      end
    end
  end

  test "decode does not decode invalid strings" do
    "!@\#$%^&*()-_+={}[]|\\:;'<>,./? ".each do |bad_char|
      assert_raise ArgumentError do
        Base62Encoder.decode "1#{bad_char}1"
      end
    end
  end

  private
  def test_cases
    { 1 => '1',
     10 => 'a',
     15 => 'f',
     16 => 'g',
     17 => 'h',
     61 => 'Z',
     62 => '10',
     63 => '11'
    }
  end
end
