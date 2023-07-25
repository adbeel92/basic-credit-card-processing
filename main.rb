#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/cards_manager'
require './lib/command_validator'

@manager = CardsManager.new

def process_file(file)
  File.open(file).each do |command_line|
    next unless CommandValidator.command_line_valid?(command_line)

    @manager.process_command(command_line)
  end

  @manager.print_cards
end

if ARGV[0]

  process_file(ARGV[0])

else

  def obtain_input
    $stdin.gets.chomp.strip
  end

  exit_commands = { 'q' => 'exit', 'q!' => 'exit!' }

  print '# '
  input = obtain_input

  until exit_commands.keys.include?(input)
    begin
      if input.split[0] == '<'

        process_file(input.split[1])

      else

        CommandValidator.filter_valid_command_lines(input).each do |command_line|
          @manager.process_command(command_line)
        end
        @manager.print_cards

      end
    rescue StandardError => e
      puts e
    end
    print '# '

    input = obtain_input
  end

  eval(exit_commands[input])

end
