# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/command_validator'

# Test validator
class CommandValidatorTest < Minitest::Test
  def test_add_command
    assert_equal(CommandValidator.validate('add Edu 12345 $1000.00'), true)
    assert_equal(CommandValidator.validate('Add  Edu  12345  $1000.00'), true)
    assert_raises(RuntimeError) { CommandValidator.validate('add') }
    assert_raises(RuntimeError) { CommandValidator.validate('add Edu 12345') }
    assert_raises(RuntimeError) { CommandValidator.validate('add Edu 12345 $1000 testing') }
  end

  def test_charge_command
    assert_equal(CommandValidator.validate('charge Edu $300'), true)
    assert_equal(CommandValidator.validate('Charge  Edu  $300'), true)
    assert_raises(RuntimeError) { CommandValidator.validate('charge') }
    assert_raises(RuntimeError) { CommandValidator.validate('charge Edu') }
    assert_raises(RuntimeError) { CommandValidator.validate('charge Edu $300 testing') }
  end

  def test_credit_command
    assert_equal(CommandValidator.validate('credit Edu $150'), true)
    assert_equal(CommandValidator.validate('Credit  Edu  $150'), true)
    assert_raises(RuntimeError) { CommandValidator.validate('credit') }
    assert_raises(RuntimeError) { CommandValidator.validate('credit Edu') }
    assert_raises(RuntimeError) { CommandValidator.validate('credit Edu $150 testing') }
  end

  def test_extra_commands
    assert_raises(RuntimeError) { CommandValidator.validate('anyword') }
    assert_raises(RuntimeError) { CommandValidator.validate('any word') }
    assert_raises(RuntimeError) { CommandValidator.validate('any word 123') }
  end
end
