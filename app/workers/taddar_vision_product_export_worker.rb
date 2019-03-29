class TaddarVisionProductExportWorker
  include Sidekiq::Worker

  def perform(product_id, user_category_id)
    ::TaddarVision::ProductService.new(product_id, user_category_id).create
  end
end
