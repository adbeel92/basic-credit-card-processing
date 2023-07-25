#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/cards_manager'
require './lib/command_validator'

def get_input
  gets.chomp.strip
end

exit_commands = { 'q' => 'exit', 'q!' => 'exit!' }

print '> '
input = get_input

manager = CardsManager.new

until exit_commands.keys.include?(input)
  begin
    puts manager.process_command(input) if CommandValidator.validate(input)
  rescue StandardError => e
    puts e
  end
  print '> '

  input = get_input
end

eval(exit_commands[input])
