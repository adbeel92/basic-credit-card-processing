#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/cards_manager'
require './lib/command_validator'

def obtain_input
  gets.chomp.strip
end

exit_commands = { 'q' => 'exit', 'q!' => 'exit!' }

print '> '
input = obtain_input

manager = CardsManager.new

until exit_commands.keys.include?(input)
  begin
    if CommandValidator.validate(input)
      manager.process_command(input)
      manager.print_cards
    end
  rescue StandardError => e
    puts e
  end
  print '> '

  input = obtain_input
end

eval(exit_commands[input])
