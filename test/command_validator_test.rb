# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/command_validator'

# Test validator
class CommandValidatorTest < Minitest::Test
  def test_add_command
    assert_equal(CommandValidator.filter_valid_command_lines('add Edu 12345 $1000.00').size, 1)
    assert_equal(CommandValidator.filter_valid_command_lines('add Edu').size, 0)
  end

  def test_add_command_multiple
    command_lines = CommandValidator.filter_valid_command_lines("Add Tom 4111111111111111 $1000
      Add Lisa 5454545454545454 $3000
      Add Quincy 1234567890123456 $2000
      add
      add Edu 12345
      add Edu 12345 $1000 testing")
    assert_equal(command_lines.size, 3)
  end

  def test_charge_command
    assert_equal(CommandValidator.filter_valid_command_lines('charge Edu $300').size, 1)
    assert_equal(CommandValidator.filter_valid_command_lines('Charge Edu').size, 0)
  end

  def test_charge_command_multiple
    command_lines = CommandValidator.filter_valid_command_lines("charge Edu $300
      Charge  Edu  $300
      charge
      charge Edu
      charge Edu $300 testing")
    assert_equal(command_lines.size, 2)
  end

  def test_credit_command
    assert_equal(CommandValidator.filter_valid_command_lines('credit Edu $150').size, 1)
    assert_equal(CommandValidator.filter_valid_command_lines('Credit Edu').size, 0)
  end

  def test_credit_command_multiple
    command_lines = CommandValidator.filter_valid_command_lines("credit Edu $150
      Credit  Edu  $150
      credit
      credit Edu
      credit Edu $150 testing")
    assert_equal(command_lines.size, 2)
  end

  def test_extra_commands
    command_lines = CommandValidator.filter_valid_command_lines("anyword
      any word
      any word 123")
    assert_equal(command_lines.size, 0)
  end
end
