module Api
  module V1
    class InstagramPostsController < ApiController
      def index
        details = Scrapers::InstagramPost.new(params[:instagram_post_url]).call
        render json: details
      end
    end
  end
end
