module CropImages
  class ImageOfInterest
    attr_reader :image_of_interest, :coordinates

    def initialize(image_of_interest, coordinates)
      @image_of_interest = image_of_interest
      @coordinates = coordinates
    end

    def call
      image_proccessor = MiniMagick::Image.open(image_url)
      width = coordinates[3].to_i - coordinates[1].to_i
      height = coordinates[2].to_i - coordinates[0].to_i
      image_proccessor.crop("#{width}x#{height}+#{coordinates[1]}+#{coordinates[0]}")
      image_proccessor.path
    end

    private

    def image_url
      image_of_interest.image.url
    end
  end
end
