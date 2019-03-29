class ProductSerializer < ActiveModel::Serializer
  attributes :uuid, :title, :price, :image_url, :redirect_url

  belongs_to :user
  has_many :images

  def price
    "#{object.display_price} #{object.currency_code}"
  end

  def user_slug
    object.user.slug
  end

  def image_url
    object.images.first&.image_url
  end
end
