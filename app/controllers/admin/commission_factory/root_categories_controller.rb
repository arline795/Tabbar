class Admin::CommissionFactory::RootCategoriesController < ApplicationController
  def show
    @importer = CommissionFactoryImporter.find(params[:importer_id])
    @category = Category.find(params[:id])
    @root_category = @importer.commission_factory_categories.find_or_create_by(category: @category)
    @commission_factory_category = @importer.commission_factory_categories.new
  end
end
