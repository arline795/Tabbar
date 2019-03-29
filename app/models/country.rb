class Country
  attr_reader :country

  def initialize(country)
    @country = ISO3166::Country(country)
  end

  def currency_symbol
    country.currency.symbol
  end

  def currency_code
    country.currency_code
  end

  def name
    country.name
  end
end
