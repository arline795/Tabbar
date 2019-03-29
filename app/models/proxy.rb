class Proxy < ApplicationRecord
  validates :ip, presence: true

  def to_phantomjs_options
    result = []
    return result if ip.blank?
    result << "--proxy=#{[ip, port].select(&:present?).join(':')}"
    return result if user.blank? || password.blank?
    result + ["--proxy-auth=#{user}:#{password}"]
  end

  def to_nokogiri_options
    options =
      if user.present? && password.present?
        {
          proxy_http_basic_authentication: [full_http_address, user, password]
        }
      else
        { proxy: full_http_address }
      end
    options['User-Agent'] = user_agent if user_agent.present?
    options
  end

  def full_address
    [ip, port].select(&:present?).join(':')
  end

  def full_http_address
    "http://#{full_address}"
  end

  def self.sample
    (all.to_a + [nil]).sample
  end

  def self.sample_nokogiri_options
    sample&.to_nokogiri_options || {}
  end
end
