# frozen_string_literal: true

require "test_helper"

class TestExtID < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ExtID::VERSION
  end

  def test_encode_known_values
    prefix = "user"
    key = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15].pack('C*')
    type = ExtID::Type.new prefix, key

    test_cases = [
      {id: ExtID::MinInt64, xid: "user_4399572cd6ea5341b8d35876a7098af7"},
      {id: -1, xid: "user_25d4e948bd5e1296afc0bf87095a7248"},
      {id: 0, xid: "user_c6a13b37878f5b826f4f8162a1c8d879"},
      {id: 1, xid: "user_13189a6ae4ab07ae70a3aabd30be99de"},
      {id: ExtID::MaxInt64, xid: "user_edc17bee21fb24e211e6419412e1c32e"},
    ]

    test_cases.each do |tc|
      xid = type.encode(tc[:id])
      assert_equal tc[:xid], xid
    end
  end

  def test_encode_decode_round_trip
    prefix = "user"
    key = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15].pack('C*')
    type = ExtID::Type.new prefix, key

    test_cases = [
      {id: ExtID::MinInt64},
      {id: -1},
      {id: 0},
      {id: 1},
      {id: ExtID::MaxInt64},
    ]

    test_cases.each do |tc|
      xid = type.encode(tc[:id])
      assert xid.start_with?(prefix+"_")
      id = type.decode(xid)
      assert_equal tc[:id], id
    end
  end
end
