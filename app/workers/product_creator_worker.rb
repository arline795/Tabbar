class ProductCreatorWorker
  include Sidekiq::Worker

  def perform(user_id, product_params, user_category_id, commission_factory_category_id)
    ProductCreatorService.new(user_id, product_params, user_category_id, commission_factory_category_id).call
  end
end
