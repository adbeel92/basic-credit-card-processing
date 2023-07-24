# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/card_number_validator'

# Test validator
class CardNumberValidatorTest < Minitest::Test
  def test_valid_ones
    assert_equal(CardNumberValidator.validate('4539319503436467'), true)
    assert_equal(CardNumberValidator.validate('4111111111111111'), true)
    assert_equal(CardNumberValidator.validate('5454545454545454'), true)
  end

  def test_invalid_ones
    assert_equal(CardNumberValidator.validate('abc123'), false)
    assert_equal(CardNumberValidator.validate('1234123412341234'), false)
    assert_equal(CardNumberValidator.validate('1234567890123456'), false)
  end
end
