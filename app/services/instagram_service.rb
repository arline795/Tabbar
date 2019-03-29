require 'net/http'

class InstagramService
  attr_reader :media, :user

  def initialize(media: nil, user: nil)
    @media = media
    @user = user
  end

  def fetch_media
    response = Net::HTTP.get(URI.parse('https://api.instagram.com/v1/media/' \
                                       "#{media.instagram_media_id}" \
                                       "?access_token=#{media.user.instagram_token}"))
    JSON.parse response
  end

  def fetch_user
    response = Net::HTTP.get(URI.parse('https://api.instagram.com/v1/users/self/' \
                                       "?access_token=#{user.instagram_token}"))
    JSON.parse response
  end
end
