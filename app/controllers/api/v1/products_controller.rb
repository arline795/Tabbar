module Api
  module V1
    class ProductsController < ApiController
      def index
        @products = Product.where_with_order(:uuid, params[:uuids].split(',').flatten)
        if @products.present?
          render json: @products
        else
          render json: []
        end
      end

      def show
        @product = Product.find_by!(uuid: params[:uuid])
        render json: @product
      rescue ActiveRecord::RecordNotFound => error
        render json: error.to_s, status: :not_found
      end
    end
  end
end
