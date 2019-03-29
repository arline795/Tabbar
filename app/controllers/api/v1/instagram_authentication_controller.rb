module Api
  module V1
    class InstagramAuthenticationController < PublicApiController
      def index
        redirect_to Instagram.authorize_url(redirect_uri: api_v1_token_url)
      end

      def token
        @response = Instagram.get_access_token(params[:code], redirect_uri: api_v1_token_url)
        @user = InstagramUserCreator.new(user_params).find_or_create
        if @user.present?
          # nqqw.app.link is link domain https://dashboard.branch.io/link-settings
          redirect_to "https://nqqw.app.link?auth_token=#{auth_token}"
        else
          redirect_to 'https://nqqw.app.link'
        end
      end

      private

      def auth_token
        AuthToken.create(@user)
      end

      def user_params
        {
          token: @response[:access_token],
          username: @response[:user][:username],
          first_name: @response[:user][:full_name].split(' ').first,
          last_name: @response[:user][:full_name].split(' ').last,
          profile_picture: @response[:user][:profile_picture],
          description: @response[:user][:bio],
          website_url: @response[:user][:website]
        }
      end
    end
  end
end
