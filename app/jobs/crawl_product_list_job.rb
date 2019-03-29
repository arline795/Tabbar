class CrawlProductListJob < ApplicationJob
  queue_as :default
  queue_with_priority 1

  delegate :product_crawler, to: :crawl_category

  def perform(crawl_category_id, modify, page)
    @crawl_category_id = crawl_category_id
    service_klass.new(crawl_category, modify, page).call!
  end

  private

  def service_klass
    return ViglinkCrawlService if product_crawler.viglink?
    product_crawler.js? ? JsCrawlProductListService : CrawlProductListService
  end

  def crawl_category
    @crawl_category ||= CrawlCategory.find(@crawl_category_id)
  end
end
