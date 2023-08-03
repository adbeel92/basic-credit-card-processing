# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/card'

# Test Card model
class CardTest < Minitest::Test
  def test_validate_name
    card = Card.new(name: 'Edu', type: 'Gold', number: '4539319503436467', limit: '$1000')
    assert_equal(card.valid?, true)

    card = Card.new(name: '', type: 'Gold', number: '4539319503436467', limit: '$1000')
    assert_equal(card.valid?, false)
  end

  def test_validate_number
    card = Card.new(name: 'Edu', type: 'Gold', number: '4539319503436467', limit: '$1000')
    assert_equal(card.valid?, true)

    card = Card.new(name: 'Edu', type: 'Gold', number: '', limit: '$1000')
    assert_equal(card.valid?, false)
  end

  def test_validate_limit
    card = Card.new(name: 'Edu', type: 'Gold', number: '4539319503436467', limit: '$1000')
    assert_equal(card.valid?, true)

    card = Card.new(name: 'Edu', type: 'Gold', number: '4539319503436467', limit: '$0')
    assert_equal(card.valid?, false)
  end

  def test_charge_card
    card = Card.new(name: 'John', type: 'Gold', number: '4539319503436467', limit: '$1000')
    card.charge('$333')
    assert_equal(card.balance, 333)
    card.charge('$111')
    assert_equal(card.balance, 444)
  end

  def test_credit_card
    card = Card.new(name: 'John', type: 'Gold', number: '4539319503436467', limit: '$1000')
    card.credit('$333')
    assert_equal(card.balance, -333)
    card.charge('$500')
    card.credit('$55')
    assert_equal(card.balance, 112)
  end
end
