# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/cards_manager'

# Test CardsManager
class CardsManagerTest < Minitest::Test
  def test_add_command
    manager.process_command('Add Tom 4111111111111111 $1500')
    manager.process_command('add Martin 4539319503436467 $1000')
    assert_equal(manager.cards[4].limit, 1500)
    assert_equal(manager.cards[5].limit, 1000)
  end

  def test_charge_command
    manager.process_command('Charge Karina $300')
    manager.process_command('charge Edu $300')
    assert_equal(manager.cards[1].balance, 300)
    assert_equal(manager.cards[3].balance, 300)
  end

  def test_credit_command
    manager.process_command('charge John $150')
    manager.process_command('credit John $100')
    manager.process_command('credit Nala $300')

    assert_equal(manager.cards[0].balance, 50)
    assert_equal(manager.cards[2].balance, -300)
  end

  def test_extra_commands
    assert_raises(ArgumentError) { manager.process_command('charge anyone $123') }
    assert_raises(ArgumentError) { manager.process_command('credit anyone $321') }
    assert_nil(manager.process_command('any word $150'))
  end

  private

  def manager
    @manager ||= CardsManager.new(
      [
        Card.new(name: 'John', number: '4539319503436467', limit: '$1000'),
        Card.new(name: 'Karina', number: '4539319503436467', limit: '$2000'),
        Card.new(name: 'Nala', number: '4539319503436467', limit: '$3000'),
        Card.new(name: 'Edu', number: '4539319503436467', limit: '$4000')
      ]
    )
  end
end
