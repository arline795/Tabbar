class TaddarVisionJob < ApplicationJob
  queue_as :default

  def perform(product)
    TaddarVision::ProductService.new(product).call
  end
end
