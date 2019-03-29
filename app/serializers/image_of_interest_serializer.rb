class ImageOfInterestSerializer < ActiveModel::Serializer
  attributes :image_url, :uuid

  belongs_to :user
  has_many :detected_products

  def image_url
    object.image.url
  end
end
