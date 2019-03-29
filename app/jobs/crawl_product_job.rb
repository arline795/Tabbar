class CrawlProductJob < ApplicationJob
  queue_as :default
  queue_with_priority 0

  def perform(crawl_category_id, url)
    crawl_category = CrawlCategory.find(crawl_category_id)
    service_klass = crawl_category.product_crawler.js? ? JsCrawlProductService : CrawlProductService
    service_klass.new(crawl_category, url).call!
  end
end
