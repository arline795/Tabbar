class ProductImageCropperWorker
  include Sidekiq::Worker

  def perform(product_id)
    product = Product.find product_id
    product_image = product.images.first
    coordinates = ObjectDetectors::ProductImageService.new(product_image, [product_image.product_image.url]).product_category_coordinates
    crop_image_url = CropImages::ProductImage.new(product_image, coordinates).call
    product_image.cropped_image = open(crop_image_url)
    product_image.save!
  end
end
