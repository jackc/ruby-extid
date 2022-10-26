# frozen_string_literal: true

require 'openssl'
require_relative "extid/version"

module ExtID
  MinInt64 = -9223372036854775808
  MaxInt64 = 9223372036854775807

  class Type
    def initialize(prefix, key)
      raise ArgumentError, "key must be exactly 16 bytes" unless key.bytesize == 16

      @prefix = prefix + "_"
      @key = key
    end

    def encode(n)
      raise ArgumentError, "n is too small" unless n >= MinInt64
      raise ArgumentError, "n is too big" unless n <= MaxInt64

      binary_number = [n].pack("q>")
      raise ArgumentError, "n could not be encoded into 64-bit binary" unless binary_number.bytesize == 8
      plaintext = binary_number + "\x0\x0\x0\x0\x0\x0\x0\x0"

      cipher = OpenSSL::Cipher.new('AES-128-ECB')
      cipher.encrypt
      cipher.key = @key
      cipher.padding = 0

      ciphertext = cipher.update(plaintext) + cipher.final
      @prefix + ciphertext.unpack("H*").first
    end

    def decode(s)
      raise ArgumentError, "invalid prefix" unless s.start_with?(@prefix)
      hex_ciphertext = s[@prefix.size..]
      ciphertext = [hex_ciphertext].pack("H*")

      cipher = OpenSSL::Cipher.new('AES-128-ECB')
      cipher.decrypt
      cipher.key = @key
      cipher.padding = 0

      plaintext = cipher.update(ciphertext) + cipher.final
      plaintext[0, 8].unpack("q>").first
    end
  end
end
