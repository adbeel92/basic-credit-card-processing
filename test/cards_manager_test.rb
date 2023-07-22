# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/cards_manager'

# Test validator
class CardsManagerTest < Minitest::Test
  def test_add_command
    manager = CardsManager.new
    assert_includes(manager.process_command('add Edu 12345 1000.00'), 'Card added successfully!')
  end

  def test_charge_command
    manager = CardsManager.new
    assert_includes(manager.process_command('charge Edu 300'), 'Card charged successfully!')
  end

  def test_credit_command
    manager = CardsManager.new
    assert_includes(manager.process_command('credit Edu 150'), 'Card credited successfully!')
  end

  def test_extra_commands
    manager = CardsManager.new
    assert_nil(manager.process_command('any word 150'))
  end
end
