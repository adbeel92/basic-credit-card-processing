# frozen_string_literal: true

# Class: CommandValidator
class CommandValidator
  ALLOWED_PARAMETER_ACTIONS = { 'add' => 4, 'charge' => 3, 'credit' => 3 }.freeze

  class << self
    def filter_valid_command_lines(command)
      command.split("\n").select do |command_line|
        command_line_valid?(command_line)
      end
    end

    def command_line_valid?(command_line)
      return false if command_line.empty?

      inputs = command_line.split
      action_valid?(inputs[0]) && parameters_valid?(inputs)
    end

    private

    def action_valid?(action)
      ALLOWED_PARAMETER_ACTIONS.keys.include?(action.downcase)
    end

    def parameters_valid?(inputs)
      ALLOWED_PARAMETER_ACTIONS[inputs[0].downcase] == inputs.size
    end
  end
end
