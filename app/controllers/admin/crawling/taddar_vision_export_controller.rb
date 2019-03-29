class Admin::Crawling::TaddarVisionExportController < Admin::BaseController
  def create
    @products = ProductCrawler.find(params[:id]).products
    @products.each do |product|
      TaddarVisionJob.perform_later(product) if product.images.any?
    end
  end
end
