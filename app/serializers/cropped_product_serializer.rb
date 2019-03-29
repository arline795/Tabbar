class CroppedProductSerializer < ActiveModel::Serializer
  attributes :image_url

  def image_url
    object.image(:large)
  end
end
