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

  def print_cards
    cards.sort_by(&:name).each { |card| print_card(card) }
  end

  def print_card(card)
    puts card.to_s
  end

  def print_card_error_messages(card)
    raise ArgumentError, card.error_messages
  end

  private

  def add_card(name, number, limit)
    card = Card.new(name: name, number: number, limit: limit)
    card.valid?
    @cards << card
  end

  def charge_card(card, amount)
    card.charge(amount)
  end

  def credit_card(card, amount)
    card.credit(amount)
  end

  def find_card_by_name(name)
    card = @cards.detect { |c| c.name.downcase == name.downcase }
    raise ArgumentError, "** Card not found by name: #{name}" if card.nil?

    card
  end
end
