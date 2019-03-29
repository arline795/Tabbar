require 'open-uri'

class CrawlProductService < BaseCrawlProductService
  private

  def page
    return @page if defined?(@page)
    @page = Nokogiri::HTML(page_html)
    @page.css(crawler.strip_css).remove
    @page
  end

  def page_html
    open(url, Proxy.sample_nokogiri_options)
  end

  def title
    page.css(crawler.title_css).text.strip
  end

  def price
    page.css(crawler.price_css).text.strip.match(/\d+(?:\.\d+)?/)[0]
  end

  def description
    return 'N/A' if crawler.description_css.blank?
    page.css(crawler.description_css).map(&:text).join('. ').presence || 'N/A'
  end

  def image_hrefs
    elements = page.css(crawler.image_css)
    image_regex = Regexp.new(crawler.image_regex)
    elements.map do |element|
      match = element.attr(crawler.image_attribute).match(image_regex)
      match && match[0]
    end.compact
  end
end
