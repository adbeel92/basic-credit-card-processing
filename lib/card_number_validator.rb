# frozen_string_literal: true

# Class: CardNumberValidator (using Luhn 10)
class CardNumberValidator
  class << self
    def validate(card_number)
      (sum_of_digits(card_number) % 10).zero?
    end

    private

    def sum_of_digits(card_number)
      digits_of(card_number).reverse.map.with_index do |digit, index|
        next digit if index.even? # starting from zero (in fact, next if odd)

        double = digit * 2
        double > 9 ? double - 9 : double
      end.inject(:+)
    end

    def digits_of(number)
      number.to_s.chars.map(&:to_i)
    end
  end
end
