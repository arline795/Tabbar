class Sanitizers::PriceSanitizer
  attr_reader :price

  def initialize(price)
    @price = price
  end

  # rubocop:disable Style/FormatString
  def dollar_to_price_in_cents
    # convers 00.00 to 0000
    price_to_2_decimal_places = sprintf '%.2f', price.to_i
    price_to_2_decimal_places.delete('.')
  end
  # rubocop:enable Style/FormatString
end
