require 'open-uri'

class JsCrawlProductListService < BaseCrawlProductListService
  private

  def execute_load_more!
    loop do
      break if crawler.load_more_css.blank?
      break if page.all(crawler.load_more_css).count.zero?
      sleep 1
      crawl_products! if crawler.paginated?
      page.all(crawler.load_more_css).first.click
      sleep 3
    end
  end

  def product_links
    page.all(crawler.product_link_css)
  end

  def page
    return @page if @page

    @page = WebScraper.scrape do |visitor|
      visitor.visit(crawl_category.url)
      visitor
    end
  end
end
