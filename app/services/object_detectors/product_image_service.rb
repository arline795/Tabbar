module ObjectDetectors
  class ProductImageService < Base
    attr_reader :product_image, :taddar_object_detector_url, :image_url

    def initialize(product_image, image_url)
      @product_image = product_image
      @image_url = image_url
    end

    def all_coordinates
      @response = fetch_category_coordinates
      return [] if @response.blank?
      @results = deserialize_response
    end

    def product_category_coordinates
      # Each product has a category so what this does is get the location
      # of that product based on category. If its a product thats a shirt this
      # will locate upper_body category coordinates.
      # Eg return ["298", "327", "609", "682"]
      return [] if all_coordinates.none?
      @results.each.flat_map do |clc|
        clc.values if clc.keys.first == category_location
      end.compact.flatten
    end

    private

    attr_reader :response

    def category_location
      ProductLocationCategory.new(product_image.product).call
    end
  end
end
