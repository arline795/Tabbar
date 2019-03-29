module Api
  module V1
    class PublicApiController < ActionController::API
      PER_PAGE = 9

      protected

      def authenticate_api_user!
        return head :unauthorized if find_current_user.nil?
      end

      def errors(object)
        object.errors.full_messages.to_sentence
      end

      def paginate(objects)
        objects.order(created_at: :desc).paginate(page: params[:page], per_page: PER_PAGE)
      end
    end
  end
end
