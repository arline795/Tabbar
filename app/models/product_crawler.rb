class ProductCrawler < ApplicationRecord
  belongs_to :user

  has_many :products, dependent: :destroy
  has_many :crawl_categories, dependent: :destroy
  has_many :categories, through: :crawl_categories

  alias_attribute :merchant, :base_url
end
