module TaddarVision
  class ProductService
    attr_reader :product, :user_category, :product_ai_product_set_id

    def initialize(product_id, user_category_id)
      @product = Product.find product_id
      @user_category = UserCategory.find user_category_id
      @product_ai_product_set_id = ENV['TADDAR_VISION_PRODUCT_SET_ID']
    end

    def create
      HTTParty.post(
        "#{ENV['TADDAR_VISION_REGION_URL']}/product_sets/_0000178/#{product_ai_product_set_id}/products",
        body: create_params.to_json,
        headers: {
          'Content-Type' => 'application/json',
          'X-Ca-Version' => '1.0',
          'X-Ca-Accesskeyid' => '1a9646b2acfce6bb8de1027f41979769'
        }
      )
    end

    private

    def create_params
      {
        image_url: product.images.first.cropped_image.url(:large),
        key_words: key_words,
        price: product.price_in_cents.to_s,
        product_id: product.id.to_s
      }
    end

    def key_words
      "#{user_category.category.parent.name} " \
        "#{ProductLocationCategory.new(product).call} " \
        "#{user_category.category.name}"
    end
  end
end
