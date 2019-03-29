require 'open-uri'

class ViglinkCrawlService < BaseCrawlProductListService
  include HTTParty

  ITEMS_PER_PAGE = 50

  private

  def has_next_page?
    product_links.present?
  end

  def product_links
    return @product_links if defined?(@product_links)

    @product_links = fetch_products['items'].to_a.map { |record| { href: record['url'] } }
  end

  def fetch_products
    self.class.get(
      ENV.fetch('VIGLINK_PRODUCT_SEARCH_URL'),
      query: {
        apiKey: ENV.fetch('VIGLINK_API_KEY'),
        merchant: crawler.merchant,
        query: crawl_category.query,
        category: crawl_category.root&.viglink_category,
        page: page_number,
        itemsPerPage: ITEMS_PER_PAGE
      },
      headers: {
        'Authorization' => ENV.fetch('VIGLINK_AUTHORIZATION')
      }
    )
  end
end
