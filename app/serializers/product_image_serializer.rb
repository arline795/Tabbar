class ProductImageSerializer < ActiveModel::Serializer
  attributes :direct_url, :position, :cropped_image_url

  def direct_url
    object.full_direct_url
  end

  def cropped_image_url
    object.cropped_image.url if object.cropped_image.present?
  end
end
