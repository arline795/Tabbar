module CropImages
  class ProductImage
    attr_reader :product_image, :coordinates

    def initialize(product_image, coordinates)
      @product_image = product_image
      @coordinates = coordinates
    end

    def call
      image_proccessor = MiniMagick::Image.open(product_image.product_image.url)
      width = coordinates[3].to_i - coordinates[1].to_i
      height = coordinates[2].to_i - coordinates[0].to_i
      image_proccessor.crop("#{width}x#{height}+#{coordinates[1]}+#{coordinates[0]}")
      image_proccessor.path
    end
  end
end
