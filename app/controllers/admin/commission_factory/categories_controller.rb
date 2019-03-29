class Admin::CommissionFactory::CategoriesController < ApplicationController
  before_action :set_crawler

  def create
    result = crawl_category_params[:category_ids].map do |category_id|
      crawl_category = @commission_factory_importer.commission_factory_categories.build(
        query: commission_factory_category_params[:query],
        category_id: category_id
      )
      crawl_category.save
    end

    if result.include?(false)
      flash[:error] = 'Cannot add categories to crawler'
    else
      flash[:success] = 'Categories added to crawler'
    end

    redirect_back(fallback_location: [:edit, :admin, :crawling, @commission_factory_importer])
  end

  def destroy
    destroyer = ::CommissionFactory::DestroyCategoryService.new(commission_factory_category).tap(&:call)
    if destroyer.errors.none?
      flash[:success] = 'Category removed from crawler'
    else
      flash[:error] = destroyer.errors.first
    end
    redirect_back(fallback_location: [:edit, :admin, :crawling, @commission_factory_importer])
  end

  def execute
    ::CommissionFactory::ImportProductsService.new(CommissionFactoryCategory.find(params[:id])).call
    flash[:success] = 'Crawling started'
    redirect_back(fallback_location: [:edit, :admin, :crawling, @commission_factory_importer])
  end

  private

  def set_crawler
    @commission_factory_importer = CommissionFactoryImporter.find(params[:importer_id])
  end

  def crawl_category_params
    params.require(:crawl_category).permit(category_ids: [])
  end

  def commission_factory_category_params
    params.require(:commission_factory_category).permit(:query)
  end

  def commission_factory_category
    @commission_factory_importer.commission_factory_categories.find(params[:id])
  end
end
