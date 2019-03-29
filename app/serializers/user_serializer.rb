class UserSerializer < ActiveModel::Serializer
  attributes :username, :avatar_url, :website_url, :country, :uuid

  def avatar_url
    object.avatar.url
  end

  def country
    return if object.country.blank?
    Country.new(object.country).name
  end
end
