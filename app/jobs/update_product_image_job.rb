class UpdateProductImageJob < ApplicationJob
  queue_as :default

  def perform(id)
    product_image = ProductImage.find(id)
    product_image.upload_to_s3!
    product_image.product
  end
end
