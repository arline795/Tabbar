module TaddarVision
  class SimilarProducts
    attr_reader :image_url, :keywords

    def initialize(params)
      @image_url = params[:image_url]
      @keywords = params[:keywords]
    end

    def call
      Product.where_with_order(:id, fetch_similar_product_ids)
    end

    private

    def fetch_similar_product_ids
      response = HTTParty.post(
        "#{ENV['TADDAR_VISION_REGION_URL']}/product_search/t4s79rkt",
        body: post_params.to_json,
        headers: {
          'Content-Type' => 'application/json',
          'X-Ca-Version' => '1.0',
          'X-Ca-Accesskeyid' => '1a9646b2acfce6bb8de1027f41979769'
        }
      )

      response['results'].map { |product| product['product_id'].to_i }
    end

    def post_params
      {
        url: image_url,
        search: keywords
      }
    end
  end
end
