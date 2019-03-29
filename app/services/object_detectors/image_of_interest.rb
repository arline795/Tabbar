module ObjectDetectors
  class ImageOfInterest < Base
    attr_reader :image_of_interest

    def initialize(image_of_interest)
      @image_of_interest = image_of_interest
      @image_url = image_of_interest.image.url
    end

    def call!
      @response = fetch_category_coordinates
      raise ProductCoordinatesNotFoundError if @response.blank?
      coordinates = deserialize_response

      coordinates.each do |corordinate|
        crop_image_url = ::CropImages::ImageOfInterest.new(
          image_of_interest, corordinate.values.first
        ).call

        DetectedProduct.create!(
          image_of_interest: image_of_interest,
          image: open(crop_image_url),
          product_coordinate: ::XAndYPointLocation.call(corordinate.values.flatten)
        )
      end
    end
  end
end
