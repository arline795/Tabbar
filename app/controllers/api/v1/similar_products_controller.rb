module Api::V1
  class SimilarProductsController < ApiController
    def create
      products = ::TaddarVision::SimilarProducts.new(params).call
      render json: products
    end
  end
end
