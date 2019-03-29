require 'open-uri'

class InstagramUserCreator
  attr_reader :username, :token, :user, :first_name, :last_name,
              :profile_picture, :description, :website_url

  def initialize(args)
    @username = args[:username]
    @token = args[:token]
    @first_name = args[:first_name]
    @last_name = args[:last_name]
    @description = args[:description]
    @profile_picture = args[:profile_picture]
    @website_url = args[:website_url]
  end

  def find_or_create
    @user = User.find_by(instagram_token: token) || User.find_by(instagram_username: username)

    if @user.blank?
      @user = User.find_or_initialize_by(instagram_username: username)
      @user.assign_attributes(
        instagram_token: token,
        avatar: profile_picture,
        roles_mask: @user.roles_mask.present? ? @user.roles_mask : User.mask_for(:regular)
      )
    end

    @user.username = @user.username.presence || username
    @user.first_name = @user.first_name.presence || first_name
    @user.last_name = @user.last_name.presence || last_name
    @user.username = @user.username.presence || username
    @user.description = @user.description.presence || description
    @user.website_url = @user.website_url.presence || website_url
    @user.website_url = @user.website_url.presence || website_url
    # uid and only required for devise token auth
    # user updates email on setup
    @user.uid = SecureRandom.urlsafe_base64(nil, false)
    @user.confirm
    @user.save
    @user
  end
  # rubocop:enable Metrics/MethodLength
end
