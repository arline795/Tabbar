module Api
  module V1
    class ImageOfInterestsController < ApiController
      def index
        render json: paginate(current_user.image_of_interests)
      end

      def create
        image_of_interest = ImageOfInterest.new(image_of_interest_params.merge(uuid: SecureRandom.uuid))
        image_of_interest.user = current_user
        if image_of_interest.save
          render json: image_of_interest
        else
          render json: { errors: 'Invalid' }, status: :unprocessable_entity
        end
      end

      def show
        image_of_interest = ImageOfInterest.find_by(uuid: params[:uuid])
        render json: image_of_interest
      end

      def destroy
        image_of_interest = ImageOfInterest.find_by(uuid: params[:uuid])
        if image_of_interest.destroy
          render json: { uuid: params[:uuid] }
        else
          render json: { errors: 'Invalid' }, status: :unprocessable_entity
        end
      end

      private

      def image_of_interest_params
        params.require(:image_of_interest).permit(:image)
      end
    end
  end
end
