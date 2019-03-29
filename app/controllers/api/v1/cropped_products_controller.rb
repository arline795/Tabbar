module Api
  module V1
    class CroppedProductsController < ApiController
      def create
        image_of_interest = ImageOfInterest.find_by(uuid: params[:image_of_interest_uuid])
        @cropped_product = CroppedProduct.find_or_initialize_by(image_of_interest: image_of_interest)
        @cropped_product.image = image_of_interest.image

        if @cropped_product.update_attributes(cropped_product_params)
          @cropped_product.reprocess_image
          render json: @cropped_product
        else
          render json: errors(@cropped_product), status: :unprocessable_entity
        end
      end

      private

      def cropped_product_params
        params.require(:cropped_product).permit(:image, :crop_x, :crop_y, :crop_w, :crop_h)
      end
    end
  end
end
