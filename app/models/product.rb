class Product < ActiveRecord::Base
  include PgSearch

  MAX_TITLE_LENGTH = 100

  belongs_to :user
  belongs_to :product_crawler, optional: true
  belongs_to :commission_factory_category, optional: true

  has_many :images, foreign_key: 'product_id', class_name: 'ProductImage', dependent: :destroy
  has_many :user_category_products, dependent: :destroy
  has_many :user_categories, through: :user_category_products
  has_many :categories, through: :user_categories

  validates :title, presence: true, length: { maximum: MAX_TITLE_LENGTH }
  validates :location, :redirect_url, presence: true
  validates :user, :price_in_cents, :description, presence: true

  before_save :ensure_absolute_redirect_url

  accepts_nested_attributes_for :images, allow_destroy: true

  monetize :price_in_cents, as: 'price'

  pg_search_scope :search, against: :title

  def thumb_image
    product_image(:thumb)
  end

  # TODO: find a default image for product and update here
  def product_image(size)
    images.presence && images[0].url(size)
  end

  def display_price
    # returns {country sybol}00.00. Eg $49.95
    return if location.blank?
    Money.new(price_in_cents, Country.new(location).currency_code).format
  end

  def product_image_ids=(values)
    values.each_with_index do |image_id, index|
      ProductImage.find(image_id).update(position: index)
    end
    super
  end

  def currency_code
    return if user.country.blank?
    Country.new(user.country).currency_code
  end

  def media_show_json
    {
      id: id,
      uuid: uuid,
      title: title,
      price: "#{display_price} #{currency_code}",
      product_id: id,
      user_id: user_id,
      user_slug: user.slug,
      image_url: images.first&.image_url,
      product_path: "/products/#{id}"
    }
  end

  def self.in_categories(categories_arr)
    root_categories = Category.roots.to_a

    ids = categories_arr.flat_map do |category_str|
      # [womens]skirts
      parent_str, cat = category_str.split(']', 2)
      parent_category = root_categories.find { |rc| parent_str.include?(rc.name) }
      if parent_category
        parent_category.descendants.where(name: cat).map(&:self_and_descendant_ids).flatten
      else
        []
      end
    end
    joins(user_category_products: :user_category)
      .where(user_categories: { category_id: ids })
  end

  private

  def ensure_absolute_redirect_url
    self.redirect_url = "http://#{redirect_url}" if redirect_url.exclude?('://')
  end
end
