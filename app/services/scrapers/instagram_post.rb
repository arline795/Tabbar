require 'mechanize'

module Scrapers
  class InstagramPost
    attr_accessor :url, :agent, :javascript_to_s

    def initialize(url)
      @url = url
      @agent = set_machanize
    end

    def call
      set_javascript

      {
        username: username,
        image_url: image_url
      }
    end

    private

    def set_machanize
      Mechanize.new do |agent|
        proxy = Proxys::LuminatiProxy.call

        agent.set_proxy(proxy[:ip], nil, proxy[:username], proxy[:password])
      end
    end

    def set_javascript
      @javascript_to_s = agent.get(url).search('script').text
    end

    def username
      'uncomment_this_later'
      # TODO: below does not work sometimes
      # use thsi url https://www.instagram.com/p/Bt_YnY4HPdj/ you will see.
      # javascript_to_s.scan(/alternateName\":\"@\w+/).first
      #                .gsub('alternateName":"@', '')
    end

    def image_url
      javascript_to_s.strip.delete("\n").delete('"').scan(/(?<=display_url:)(.*)(?=,display_resources)/).flatten
                     .first.split(',').first
    end

    def page_html
      open(url, Proxy.sample_nokogiri_options)
    end
  end
end
