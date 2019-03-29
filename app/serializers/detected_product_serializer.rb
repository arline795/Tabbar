class DetectedProductSerializer < ActiveModel::Serializer
  attributes :image_url, :thumb_url, :product_coordinate

  def image_url
    object.image.url
  end

  def thumb_url
    object.image(:small)
  end
end
