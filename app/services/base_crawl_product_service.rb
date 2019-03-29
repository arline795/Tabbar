class BaseCrawlProductService
  attr_reader :crawler, :crawl_category, :url, :product

  MAX_RETRY_ATTEMPTS = 3
  RETRY_INTERVAL = 10

  def initialize(crawl_category, url)
    @crawl_category = crawl_category
    @crawler = crawl_category.product_crawler
    @url = url
  end

  def call!
    @product = Product.find_or_initialize_by(redirect_url: url)

    MAX_RETRY_ATTEMPTS.times do
      break if title.present?
      sleep RETRY_INTERVAL
    end

    product.assign_attributes(
      title: title,
      price: price,
      description: description,
      location: crawler.location,
      user: crawler.user,
      product_crawler: crawler,
      uuid: SecureRandom.uuid
    )
    product.save!
    product.user_category_products.find_or_create_by(user_category: user_category)

    create_product_images!
  end

  protected

  def create_product_images!
    product.images.destroy_all
    # If you want to create product images on all images found on page
    # loop through image_hrefs
    image_href = image_hrefs.first
    image_url = image_hrefs.first.include?('//') ? image_href : "#{crawler.base_url}/#{image_href}"
    product_image = product.images.create!(direct_url: image_url)
    UpdateProductImageJob.perform_later(product_image.id)
  end

  def user_category
    @user_category ||=
      crawler.user.user_categories.find_by(
        category_id: crawl_category.category_id
      )
  end
end
