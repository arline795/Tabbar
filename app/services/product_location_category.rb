class ProductLocationCategory
  attr_reader :product, :category

  def initialize(product)
    @product = product
    @category = product.categories.first
  end

  def call
    location_settings[category.root.name.to_s][category.name.to_s].first
  end

  # rubocop:disable Metrics/MethodLength
  # TODO this was a yaml file but didnt load in sidekiq. Make
  # it a yaml file.
  def location_settings
    {
      'women' => {
        'bridal' => ['full_body'],
        'coats_and_jackets' => ['upper_body'],
        'dresses' => ['full_body'],
        'jeans' => ['lower_body'],
        'jumpsuits' => ['full_body'],
        'knitwear_and_pullover' => ['lower_body'],
        'pants' => ['lower_body'],
        'shirts' => ['upper_body'],
        'shorts' => ['lower_body'],
        'skirts' => ['lower_body'],
        'sweaters_and_hoodies' => ['upper_body'],
        'swimwear' => ['full_body'],
        'tops' => ['upper_body']
      },
      'men' => {
        'coats_and_jackets' => ['upper_body'],
        'jeans' => ['lower_body'],
        'pants' => ['lower_body'],
        'shirts' => ['upper_body'],
        'shorts' => ['lower_body'],
        'sweaters_and_hoodies' => ['upper_body']
      }
    }
  end
  # rubocop:enable Metrics/MethodLength
end
