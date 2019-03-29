class Admin::Crawling::CrawlCategoriesController < ApplicationController
  before_action :set_crawler

  def create
    result = crawl_category_params[:category_ids].map do |category_id|
      crawl_category = @product_crawler.crawl_categories.build(
        url: crawl_category_params[:url],
        category_id: category_id
      )
      crawl_category.save
    end

    if result.include?(false)
      flash[:error] = 'Cannot add categories to crawler'
    else
      flash[:success] = 'Categories added to crawler'
    end

    redirect_back(fallback_location: [:edit, :admin, :crawling, @product_crawler])
  end

  def update
    crawl_category = @product_crawler.crawl_categories.find(params[:id])

    if crawl_category.update(update_params)
      flash[:success] = 'Settings updated'
    else
      flash[:error] = 'Cannot update the settings'
    end

    redirect_back(fallback_location: [:edit, :admin, :crawling, @product_crawler])
  end

  def destroy
    crawl_category = @product_crawler.crawl_categories.find(params[:id])
    crawl_category.destroy

    flash[:success] = 'Category removed from crawler'

    redirect_back(fallback_location: [:edit, :admin, :crawling, @product_crawler])
  end

  private

  def set_crawler
    @product_crawler = ProductCrawler.find(params[:product_crawler_id])
  end

  def crawl_category_params
    params.require(:crawl_category).permit(:url, category_ids: [])
  end

  def update_params
    params.require(:crawl_category).permit(:viglink_category)
  end
end
