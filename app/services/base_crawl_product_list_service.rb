require 'open-uri'

class BaseCrawlProductListService
  attr_reader :crawl_category, :crawler, :modify, :page_number

  def initialize(crawl_category, modify, page_number = 1)
    @crawl_category = crawl_category
    @crawler = crawl_category.product_crawler
    @modify = modify
    @page_number = page_number
  end

  def call!
    create_user_categories!
    execute_load_more!
    crawl_products!
    CrawlProductListJob.perform_later(crawl_category.id, modify, page_number + 1) if has_next_page?
  end

  protected

  def execute_load_more!
  end

  def has_next_page?
    false
  end

  def crawl_products!
    urls = product_links.map do |product_link_css|
      href = product_link_css[:href]
      url = href.include?('//') ? href : "#{crawler.base_url}/#{href}"
      CrawlProductJob.perform_later(crawl_category.id, url)
      url
    end

    crawl_category.products.where(redirect_url: urls).update_all(crawled: true)
    crawl_category.products.where(crawled: false).destroy_all unless has_next_page?
  end

  private

  def create_user_categories!
    category = crawl_category.category
    category.ancestors.to_a.each do |cat|
      crawler.user.user_categories.find_or_create_by(category: cat)
    end
    crawler.user.user_categories.find_or_create_by(
      category: category
    )
  end
end
