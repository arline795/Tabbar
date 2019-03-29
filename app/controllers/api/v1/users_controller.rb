module Api
  module V1
    class UsersController < ApiController
      before_action :set_user

      def show
        if @user
          render json: @user
        else
          render json: { errors: "Can't find user" }, status: :not_found
        end
      end

      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: { errors: @user.errors.full_messages.to_sentence }, status: :not_found
        end
      end

      private

      def set_user
        @user = User.find_by(uuid: params[:uuid])
      end

      def user_params
        params.require(:user).permit(:username, :slug, :email, :country, :token)
      end
    end
  end
end
