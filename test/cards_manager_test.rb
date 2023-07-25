# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/cards_manager'

# Test CardsManager
class CardsManagerTest < Minitest::Test
  def test_add_command
    assert_includes(manager.process_command('Add Tom 4111111111111111 $1500'), 'Card added!')
    assert_includes(manager.process_command('add Martin 4539319503436467 $1000'), 'Card added!')
  end

  def test_charge_command
    assert_includes(manager.process_command('Charge Karina $300'), 'Card charged successfully!')
    assert_includes(manager.process_command('charge Edu $300'), 'Card charged successfully!')

    assert_raises(ArgumentError) { manager.process_command('charge anyone $300') }
  end

  def test_credit_command
    manager.cards.last.charge('$100')
    assert_includes(manager.process_command('credit Edu $150'), 'Card credited successfully!')

    assert_raises(ArgumentError) { manager.process_command('credit Nala $300') }

    assert_raises(ArgumentError) { manager.process_command('credit anyone $300') }
  end

  def test_extra_commands
    assert_nil(manager.process_command('any word $150'))
  end

  private

  def manager
    @manager ||= CardsManager.new(
      [
        Card.new(name: 'John', number: '12345', limit: '$1000'),
        Card.new(name: 'Karina', number: '23456', limit: '$2000'),
        Card.new(name: 'Nala', number: '34567', limit: '$3000'),
        Card.new(name: 'Edu', number: '45678', limit: '$4000')
      ]
    )
  end
end
