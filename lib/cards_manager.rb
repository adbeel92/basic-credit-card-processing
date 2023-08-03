# frozen_string_literal: true

require './lib/card'

# class: CardsManager
class CardsManager
  attr_reader :cards

  def initialize(cards = {})
    @cards = cards
  end

  def process_command(command)
    inputs = command.split
    action = inputs[0]
    name = inputs[1]
    type = inputs[2]
    case action.downcase
    when 'add'
      number = inputs[3]
      limit = inputs[4]
      add_card(name, type, number, limit)
    when 'charge'
      amount = inputs[3]
      charge_card(find_card_by_name_and_type(name, type), amount)
    when 'credit'
      amount = inputs[3]
      credit_card(find_card_by_name_and_type(name, type), amount)
    end
  end

  def print_cards
    cards.sort.each do |name, card_types|
      types = card_types.sort.collect { |card_type, card| "(#{card_type}): #{card.balance_detail}" }.join(', ')
      puts "#{name}: #{types}"
    end
  end

  def print_card(card)
    puts card.to_s
  end

  def print_card_error_messages(card)
    raise ArgumentError, card.error_messages
  end

  private

  def add_card(name, type, number, limit)
    card = Card.new(name: name, type: type, number: number, limit: limit)
    card.valid?
    @cards[name] ||= {}
    @cards[name][type] = card
  end

  def charge_card(card, amount)
    card.charge(amount)
  end

  def credit_card(card, amount)
    card.credit(amount)
  end

  def find_card_by_name_and_type(name, type)
    card = @cards.dig(name, type)
    raise ArgumentError, "** Card not found by name: #{name}, and type: #{type}" if card.nil?

    card
  end
end
