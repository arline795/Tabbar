require 'open-uri'

class CrawlProductListService < BaseCrawlProductListService
  private

  def product_links
    page.css(crawler.product_link_css)
  end

  def page_html
    open(crawl_category.url, Proxy.sample_nokogiri_options)
  end

  def page
    return @page if defined?(@page)
    @page = Nokogiri::HTML(page_html)
    @page
  end
end
