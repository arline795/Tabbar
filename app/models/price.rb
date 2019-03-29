class Price
  attr_reader :country, :price_in_cents

  def initialize(country, price_in_cents)
    @country = country
    @price_in_cents = price_in_cents
  end

  def display_price
    "#{Country.new(country).currency_symbol}#{price}"
  end

  private

  def price
    Money.new(
      price_in_cents,
      Country.new(country).currency_code
    )
  end
end
