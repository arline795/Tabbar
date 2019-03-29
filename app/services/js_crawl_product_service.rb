class JsCrawlProductService < BaseCrawlProductService
  private

  def page
    return @page if @page

    @page = WebScraper.scrape do |visitor|
      visitor.visit(url)

      visitor
    end
  end

  def title
    page.find(crawler.title_css).text.strip
  rescue Capybara::Poltergeist::StatusFailError
    nil
  end

  def price
    page.find(crawler.price_css).text.strip.match(/\d+(?:\.\d+)?/)[0]
  end

  def description
    return 'N/A' if crawler.description_css.blank?
    page.all(crawler.description_css).map(&:text).join('. ').presence || 'N/A'
  end

  def image_hrefs
    elements = page.all(crawler.image_css)
    image_regex = Regexp.new(crawler.image_regex)
    elements.map do |element|
      match = element[crawler.image_attribute].match(image_regex)
      match && match[0]
    end.compact
  end
end
