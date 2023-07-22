# frozen_string_literal: true

# class: CardsManager
class CardsManager
  attr_reader :cards

  def initialize
    @cards = []
  end

  def process_command(command)
    inputs = command.split
    action = inputs[0]
    name = inputs[1]
    case action
    when 'add'
      number = inputs[2]
      limit = inputs[3]
      add_card(name, number, limit)
    when 'charge'
      amount = inputs[2]
      charge_card(find_card_by_name(name), amount)
    when 'credit'
      amount = inputs[2]
      credit_card(find_card_by_name(name), amount)
    end
  end

  private

  def add_card(_name, _number, _limit)
    @cards << OpenStruct.new
    '# Card added successfully!'
  end

  def charge_card(_card, _amount)
    '# Card charged successfully!'
  end

  def credit_card(_card, _amount)
    '# Card credited successfully!'
  end

  def find_card_by_name(_name)
    OpenStruct.new
  end
end
