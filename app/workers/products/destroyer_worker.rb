module Products
  class DestroyerWorker
    include Sidekiq::Worker

    def perform(product_id)
      ::TaddarVision::DestroyProduct.new(product_id).call

      Product.find(product_id).destroy
    end
  end
end
