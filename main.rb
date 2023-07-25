#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/cards_manager'
require './lib/command_validator'

def obtain_input
  STDIN.gets.chomp.strip
end

exit_commands = { 'q' => 'exit', 'q!' => 'exit!' }

print '> '
input = obtain_input

manager = CardsManager.new

until exit_commands.keys.include?(input)
  begin
    valid_command_lines = CommandValidator.filter_valid_command_lines(input)

    valid_command_lines.each do |command_line|
      manager.process_command(command_line)
    end

    manager.print_cards
  rescue StandardError => e
    puts e
  end
  print '> '

  input = obtain_input
end

eval(exit_commands[input])
