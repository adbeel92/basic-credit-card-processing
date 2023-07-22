#!/usr/bin/env ruby

exit_commands = { 'q' => 'exit', 'q!' => 'exit!' }

print "> "
input = gets.chomp.strip

while !exit_commands.keys.include?(input)
  begin

    puts input.chars.inspect

  rescue => exception
    puts exception
  end
  print "> "

  input = gets.chomp.strip
end

eval(exit_commands[input])
