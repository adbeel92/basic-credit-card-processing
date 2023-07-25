# frozen_string_literal: true

require './lib/card'

# class: CardsManager
class CardsManager
  attr_reader :cards

  def initialize(cards = [])
    @cards = cards
  end

  def process_command(command)
    inputs = command.split
    action = inputs[0]
    name = inputs[1]
    case action.downcase
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

  def add_card(name, number, limit)
    card = Card.new(name: name, number: number, limit: limit)
    card.valid?
    @cards << card
    '# Card added!'
  end

  def charge_card(card, amount)
    print_card_error_messages(card) unless card.charge(amount)

    "# Card charged successfully! #{card.name} $#{card.balance.to_f}"
  end

  def credit_card(card, amount)
    print_card_error_messages(card) unless card.credit(amount)

    "# Card credited successfully! #{card.name} $#{card.balance.to_f}"
  end

  def find_card_by_name(name)
    card = @cards.detect { |c| c.name.downcase == name.downcase }
    raise ArgumentError, "** Card not found by name: #{name}" if card.nil?

    card
  end

  def print_card_error_messages(card)
    raise ArgumentError, card.error_messages
  end
end
