class Admin::CommissionFactory::ProductsDestroyerController < Admin::BaseController
  before_action :set_products

  def create
    if @products.any?
      flash[:notice] = 'Products are being destroyed'
      @products.each do |product|
        Products::DestroyerWorker.perform_async(product.id)
      end
    else
      flash[:error] = 'Error destroying products'
    end

    redirect_to(:back, fallback: root_path)
  end

  private

  def set_products
    if params[:commission_factory_category_id].present?
      user_category_products
    else
      @products = CommissionFactoryImporter.find(params[:crawler_id]).user.products if params[:crawler_id]
      @products = @products.where(crawled: false) if params[:crawled] == 'false'
    end
  end

  def user_category_products
    user_category = UserCategory.find_by(
      category: CommissionFactoryCategory.find(params[:commission_factory_category_id]).category,
      user:  CommissionFactoryImporter.find(params[:crawler_id]).user
    )

    @products = UserCategoryProduct.where(user_category: user_category).map(&:product)
  end
end
