# frozen_string_literal: true

require_relative '../lib/card_number_validator'

# class: Card
class Card
  attr_reader :name, :type, :number, :limit, :balance, :error_messages

  def initialize(args)
    @name = args[:name].capitalize if args[:name]
    @type = args[:type]
    @number = args[:number]
    @limit = args[:limit].to_s.gsub('$', '').to_f if args[:limit]
    @balance = 0
    @error_messages = {}
  end

  def valid?
    name_valid? && number_valid? && limit_valid? && balance_valid?
  end

  def to_s
    "#{name}: #{balance_detail}"
  end

  def type_description
    "(#{type}): #{balance_detail}"
  end

  def balance_detail
    valid? ? "$#{balance}" : 'error'
  end

  def charge(amount)
    return unless valid?

    bal = @balance
    @balance += amount.to_s.gsub('$', '').to_f
    return @balance if balance_valid?

    @balance = bal
  end

  def credit(amount)
    return unless valid?

    @balance -= amount.to_s.gsub('$', '').to_f
  end

  private

  def name_valid?
    return true unless name && name.empty?

    add_error_message(:name, 'is not valid')
  end

  def number_valid?
    return true if number && !number.empty? && number.length <= 19 && CardNumberValidator.validate(number)

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
