class Admin::Crawling::RootCategoriesController < ApplicationController
  def show
    @product_crawler = ProductCrawler.find(params[:product_crawler_id])
    @category = Category.find(params[:id])
    @root_crawl_category =
      @product_crawler.crawl_categories.find_or_create_by(category: @category)
    @crawl_category = @product_crawler.crawl_categories.new
  end
end
