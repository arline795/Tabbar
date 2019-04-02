module CommissionFactory
  class DestroyCategoryService
    attr_reader :errors

    def initialize(commission_factory_contegory)
      @commission_factory_contegory = commission_factory_contegory
      @category = commission_factory_contegory.category
      @user = commission_factory_contegory.commission_factory_importer.user
      @user_categories = UserCategory.where(category: category, user: user)
      @errors = []
    end

    def call
      return commission_factory_contegory.destroy! if user_categories.empty?
      user_categories_and_products!
      commission_factory_contegory.destroy!
    rescue StandardError => error
      errors << error
    end

    private

    attr_reader :commission_factory_contegory, :category, :user, :user_category, :user_categories

    def user_categories_and_products!
      user_categories.each do |uc|
        uc.products.each do |p|
          ::Products::DestroyerWorker.perform_async(p.id)
        end
        uc.destroy!
      end
    end
  end
end
