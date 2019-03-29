module ProductAi
  class Exporter
    attr_reader :user_category

    def initialize(user_category)
      @user_category = user_category
    end

    def call
      user_category.products.each do |product|
        ::ProductAi::CreateProductWorker.perform_async(
          product.id,
          user_category.id
        )
      end
    end
  end
end
