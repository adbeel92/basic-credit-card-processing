# frozen_string_literal: true

require_relative '../lib/card_number_validator'

# class: Card
class Card
  attr_reader :name, :number, :limit, :balance, :error_messages

  def initialize(args)
    @name = args[:name].capitalize if args[:name]
    @number = args[:number]
    @limit = args[:limit].to_f if args[:limit]
    @balance = nil
    @error_messages = {}
  end

  def valid?
    name_valid? && number_valid? && limit_valid? && balance_valid?
  end

  def charge(amount)
    @balance ||= 0
    bal = @balance
    @balance += amount.to_f

    return true if balance_valid?

    @balance = bal
  end

  def credit(amount)
    if balance
      @balance -= amount.to_f
      return true
    end

    add_error_message(:balance, 'is not valid')
  end

  private

  def name_valid?
    return true unless name && name.empty?

    add_error_message(:name, 'is not valid')
  end

  def number_valid?
    return true if number && !number.empty? && CardNumberValidator.validate(number)

    add_error_message(:number, 'is not valid')
  end

  def limit_valid?
    return true if limit&.positive?

    add_error_message(:limit, 'must be greater than 0')
  end

  def balance_valid?
    return true if balance.to_f <= limit

    add_error_message(:balance, 'must not be greater than limit')
  end

  def add_error_message(attr, message)
    @error_messages[attr] ||= []
    @error_messages[attr] << message
    false
  end
end
