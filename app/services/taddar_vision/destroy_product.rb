module TaddarVision
  class DestroyProduct
    attr_reader :product, :product_ai_product_set_id

    def initialize(product_id)
      @product = Product.find product_id
      @product_ai_product_set_id = 'k7mtgl0s'
    end

    def call
      HTTParty.delete(
        "#{ENV['TADDAR_VISION_REGION_URL']}/product_sets/_0000178/#{product_ai_product_set_id}/products",
        body: { "ids": [product.id.to_s] }.to_json,
        headers: {
          'Content-Type' => 'application/json',
          'X-Ca-Version' => '1.0',
          'X-Ca-Accesskeyid' => '1a9646b2acfce6bb8de1027f41979769'
        }
      )
    end
  end
end
