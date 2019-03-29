require 'mini_magick'

class ProductImagesService
  attr_reader :product, :image_urls, :category_location

  def initialize(product, image_urls)
    @product = product
    @image_urls = image_urls
  end

  def call
    create_images_and_assign_cropped_image!
    product.images.reload
  end

  private

  def create_images_and_assign_cropped_image!
    raise EmptyArrayError if image_urls.none?

    image_urls.each do |image_url|
      product_image = ProductImage.create!(
        product: product,
        product_image: get_image_by_proxy(image_url)
      )

      assign_cropped_image(product_image)
    end
  end

  def assign_cropped_image(product_image)
    coordinates = ObjectDetectors::ProductImageService.new(product_image, product_image.product_image.url).product_category_coordinates
    raise ProductCoordinatesNotFoundError if coordinates.none?
    crop_image_url = CropImages::ProductImage.new(product_image, coordinates).call
    product_image.cropped_image = open(crop_image_url)
    product_image.save!
  end

  def get_image_by_proxy(image_url)
    # Do this so we remained undetected from the brands servers
    Proxys::OpenFile.new(image_url).call
  end
end
