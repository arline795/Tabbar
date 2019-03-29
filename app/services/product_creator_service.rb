class ProductCreatorService
  require 'open-uri'
  attr_reader :user, :product_params, :user_category_id, :product, :commission_factory_category

  def initialize(user_id, product_params, user_category_id, commission_factory_category_id = nil)
    @user = User.find user_id
    @product_params = product_params.symbolize_keys!
    @user_category_id = user_category_id
    @commission_factory_category = CommissionFactoryCategory.find_by(id: commission_factory_category_id)
  end

  def call
    ActiveRecord::Base.transaction do
      find_or_create_product
      product.images.destroy_all
      find_or_create_user_category_product
      find_or_create_product_images
    end

    export_to_taddar_vision
    remove_duplicates
  end

  private

  def find_or_create_product
    @product = Product.find_or_initialize_by(redirect_url: product_params[:redirect_url])
    product.user = user
    product.title = product_params[:name]
    product.description = product_params[:description]
    product.price_in_cents = product_params[:price_in_cents]
    product.location = product_params[:country]
    product.uuid = SecureRandom.uuid
    product.crawled = true
    product.redirect_url = product_params[:redirect_url]
    product.commission_factory_category = commission_factory_category
    product.save!
  end

  def remove_duplicates
    products_to_destroy = user.products
                              .where(redirect_url: product_params[:redirect_url])
                              .where.not(id: @product.id)

    products_to_destroy.each do |old_product|
      ::Products::DestroyerWorker.perform_async(old_product.id)
      UserCategoryProduct.where(product: old_product).destroy_all
      ProductImage.where(product: old_product).destroy_all
      old_product.destroy
    end
  end

  def find_or_create_user_category_product
    user_category = UserCategory.find_by!(id: user_category_id)
    UserCategoryProduct.find_or_create_by!(user_category: user_category, product: product)
  end

  def find_or_create_product_images
    ProductImagesService.new(product, product_params[:image_urls]).call
  end

  def export_to_taddar_vision
    TaddarVisionProductExportWorker.perform_async(product.id, user_category_id)
  end
end
