# frozen_string_literal: true

# Class: CommandValidator
class CommandValidator
  ALLOWED_PARAMETER_ACTIONS = { 'add' => 4, 'charge' => 3, 'credit' => 3 }.freeze

  class << self
    def validate(command)
      return if command.empty?

      inputs = command.split

      validate_action(inputs[0])
      validate_parameters(inputs)
    end

    private

    def validate_action(action)
      return true if ALLOWED_PARAMETER_ACTIONS.keys.include?(action)

      raise "Invalid action: `#{action}`"
    end

    def validate_parameters(inputs)
      return true if ALLOWED_PARAMETER_ACTIONS[inputs[0]] == inputs.size

      raise 'Invalid input parameters'
    end
  end
end
