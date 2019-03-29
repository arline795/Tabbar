class CrawlCategory < ApplicationRecord
  belongs_to :category
  belongs_to :product_crawler

  validates :url, presence: true, unless: :root?

  alias_attribute :query, :url

  scope :crawlable, -> { where.not(url: nil) }

  delegate :root?, to: :category

  def root
    product_crawler.crawl_categories.find_by(category: category.root)
  end

  def user_categories
    category.user_categories.where(user: product_crawler.user)
  end

  def user_category_products
    UserCategoryProduct.where(user_category: user_categories)
  end

  def products
    Product.where(id: user_category_products.pluck(:product_id))
  end

  def cleanup_products_except(urls)
    to_be_cleaned = products.where.not(redirect_url: urls)
    user_category_products.where(product: to_be_cleaned).destroy_all
    to_be_deleted_ids = Product.pluck(:id) - UserCategoryProduct.pluck(:product_id)
    Product.where(id: to_be_deleted_ids).destroy_all
  end
end
