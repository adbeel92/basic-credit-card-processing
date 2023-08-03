# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/cards_manager'

# Test CardsManager
class CardsManagerTest < Minitest::Test
  def test_add_command
    manager.process_command('Add Tom Type1 4111111111111111 $1500')
    manager.process_command('add Martin Type2 4539319503436467 $1000')
    assert_equal(manager.cards['Tom']['Type1'].limit, 1500)
    assert_equal(manager.cards['Martin']['Type2'].limit, 1000)
  end

  def test_charge_command
    manager.process_command('Charge Karina Platinum $300')
    manager.process_command('charge Edu Home $300')
    assert_equal(manager.cards['Karina']['Platinum'].balance, 300)
    assert_equal(manager.cards['Edu']['Home'].balance, 300)
  end

  def test_credit_command
    manager.process_command('charge John Gold $150')
    manager.process_command('credit John Gold $100')
    manager.process_command('credit Nala Work $300')

    assert_equal(manager.cards['John']['Gold'].balance, 50)
    assert_equal(manager.cards['Nala']['Work'].balance, -300)
  end

  def test_extra_commands
    assert_raises(ArgumentError) { manager.process_command('charge anyone AnyType $123') }
    assert_raises(ArgumentError) { manager.process_command('credit anyone AnyType $321') }
    assert_nil(manager.process_command('any word AnyType $150'))
  end

  private

  def manager
    @manager ||= CardsManager.new(
      {
        'John' => {
          'Gold' => Card.new(name: 'John', type: 'Gold', number: '4539319503436467', limit: '$1000')
        },
        'Karina' => {
          'Platinum' => Card.new(name: 'Karina', type: 'Platinum', number: '4539319503436467', limit: '$2000')
        },
        'Nala' => {
          'Work' => Card.new(name: 'Nala', type: 'Work', number: '4539319503436467', limit: '$3000')
        },
        'Edu' => {
          'Home' => Card.new(name: 'Edu', type: 'Home', number: '4539319503436467', limit: '$4000')
        }
      }
    )
  end
end
