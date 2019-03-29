module Products
  class DestroyerWorker
    include Sidekiq::Worker

    def perform(product_id, user_category_id)
      ::TaddarVision::ProductService.new(product_id, user_category_id).destroy

      Product.find(product_id).destroy
    end
  end
end
