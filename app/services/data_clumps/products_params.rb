module DataClumps
  class ProductsParams
    attr_reader :name, :description, :price_in_cents, :country, :redirect_url, :image_urls

    # rubocop:disable Metrics/ParameterLists
    def initialize(name, description, price_in_cents, country, redirect_url, image_urls)
      @name = name
      @description = description
      @price_in_cents = price_in_cents
      @country = country
      @redirect_url = redirect_url
      @image_urls = image_urls
    end
    # rubocop:enable Metrics/ParameterLists

    def to_hash
      {
        name: name,
        description: description,
        price_in_cents: price_in_cents,
        country: country,
        redirect_url: redirect_url,
        image_urls: image_urls
      }
    end
  end
end
