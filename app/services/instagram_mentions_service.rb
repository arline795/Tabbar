require 'net/http'

class InstagramMentionsService
  GRAPH_API_BASE = 'https://graph.facebook.com'.freeze
  GRAPH_API_HEADERS = {
    'Content-Type' => 'json',
    'Authorization' => "Bearer #{ENV['GRAPH_API_PAGE_ACCESS_TOKEN']}"
  }.freeze

  attr_reader :media_id, :comment_id, :image_of_interest

  def initialize(media_id, comment_id)
    @media_id = media_id
    @comment_id = comment_id
  end

  def execute!
    find_or_create_user
    image_of_interest_orchestrator! if @user.present?
  end

  private

  def image_of_interest_orchestrator!
    ActiveRecord::Base.transaction do
      create_image_of_interest!(image_url)
      create_detected_product!
    end
  end

  def create_image_of_interest!(image_url)
    @image_of_interest = ImageOfInterest.create!(user: @user, image: image_url)
  end

  def create_detected_product!
    ObjectDetectors::ImageOfInterest.new(image_of_interest).call!
  end

  def find_or_create_user
    @user = User.find_or_initialize_by(instagram_username: username)
    if @user.persisted?
      @user
    else
      create_user
    end
  end

  def create_user
    @user.username = username
    @user.roles = [:regular]
    @user.password = SecureRandom.uuid
    @user.save(validate: false)
    # If you dont validate false you will need to require
    # email. Email is not required here because they will
    # provide it when they login for the first time
  end

  def image_url
    response = get_response("/#{media_id}?fields=mentioned_media.media_id(#{media_id}){media_url}")
    response['mentioned_media']['media_url']
  end

  def username
    response = get_response("/#{comment_id}?fields=username")
    @username ||= response['username']
  end

  def get_response(endpoint)
    HTTParty.get("#{GRAPH_API_BASE}#{endpoint}", headers: GRAPH_API_HEADERS)
  end
end
