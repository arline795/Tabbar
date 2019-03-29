class InstagramController < ApplicationController
  IMAGES_PER_LOAD = 9
  before_action :authenticate_user!

  def instagram_images
    # TODO: Move to own controller
    images_json = images.map do |image|
      {
        id: image['id'],
        media_id: image['id'],
        instagram: true,
        description: image['caption']['text'],
        user_slug: user.slug,
        user_avatar: user.avatar.url(:thumb),
        user_name: user.username,
        media_img_path: image['images']['low_resolution']['url'],
        likes_count: image['likes']['count']
      }
    end

    render json: {
      medias: images_json,
      next_max_id: images.pagination.next_max_id,
      has_more: images.pagination.next_max_id.present?
    }
  end

  def authenticate
    redirect_to Instagram.authorize_url(redirect_uri: auth_instagram_callback_url, scope: :public_content)
  end

  private

  def user
    @user ||= if params[:username].blank?
                current_user
              else
                User.friendly.find(params[:username])
              end
  end

  def client
    @client ||= Instagram.client(access_token: user.instagram_token)
  end

  def images
    @images ||= client.user_recent_media(max_id: params[:max_id], count: IMAGES_PER_LOAD)
  end
end
