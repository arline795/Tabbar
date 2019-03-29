require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

class WebScraper
  include Capybara::DSL
  Capybara.default_driver = :poltergeist
  Capybara.register_driver :poltergeist do |app|
    options = { js_errors: false, timeout: 120 }
    Capybara::Poltergeist::Driver.new(app, options)
  end

  def refresh
    proxy = Proxy.sample

    if proxy
      Capybara.register_driver :proxied_poltergeist do |app|
        options = {
          js_errors: false,
          phantom_js_options: proxy.to_phantomjs_options
        }
        js_drive = Capybara::Poltergeist::Driver.new(app, options)
        js_drive.headers = { 'User-Agent' => proxy.user_agent }
        js_drive
      end
      Capybara.current_driver = :proxied_poltergeist
    else
      Capybara.current_driver = :poltergeist
    end
  end

  def scrape
    yield page
  end

  def self.scrape(&block)
    instance = new
    instance.refresh
    instance.scrape(&block)
  end
end
