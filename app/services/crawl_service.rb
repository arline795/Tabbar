require 'open-uri'

class CrawlService
  attr_reader :crawler, :modify

  def initialize(crawler, modify)
    @crawler = crawler
    @modify = modify
  end

  def call!
    crawler.products.update_all(crawled: false)

    crawler.crawl_categories.crawlable.find_each do |crawl_category|
      CrawlProductListJob.perform_later(crawl_category.id, modify, 1)
    end
  end
end
