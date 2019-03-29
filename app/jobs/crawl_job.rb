class CrawlJob < ApplicationJob
  queue_as :default

  def perform(crawler_id, modify)
    crawler = ProductCrawler.find(crawler_id)
    CrawlService.new(crawler, modify).call!
  end
end
