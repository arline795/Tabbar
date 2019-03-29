class ProductImagesWorker
  include Sidekiq::Worker

  def perform(product_id, image_urls)
    ProductImagesService.new(product_id, image_urls).call
  end
end
