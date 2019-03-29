# TODO. This base class is bad.
# Its not implicit and it can only it creates a bad dependency.
# Should be its own class that only takes to the Taddar Object Detector
module ObjectDetectors
  class Base
    def fetch_category_coordinates
      HTTParty.get("#{ENV['TADDAR_OBJECT_DETECTOR_URL']}#{@image_url}",
                   headers: { 'Content-Type' => 'application/json' })
    end

    def deserialize_response
      # \t means it has more then 1 category
      @response.count("\t") >= 2 ? deserialize_to_aray : [convert_to_hash(@response)]
    end

    def deserialize_to_aray
      @response[0] = ''
      category_coordinates = @response.split("\n")
      category_coordinates.map do |cc|
        convert_to_hash(cc)
      end
    end

    def convert_to_hash(category_coordinate)
      category_then_coordinates = category_coordinate.split(' ')
      hash = {}
      hash[category_then_coordinates.first.downcase] = category_then_coordinates.last.split(',')
      hash
    end

    # Uncomment this to import products from csv found in test fixtures and ploce
    # product_image with this method
    # def url_to_use
    #   if image.product.title == 'Oversized Off Shoulder Batwing Sleeve Casual Dress'
    #     'https://c.cfjump.com/Products/49287/75867846.jpg'
    #   elsif image.product.title == 'Contrast Hem Hollow Out Bodycon Dress'
    #     'https://c.cfjump.com/Products/49287/75867848.jpg'
    #   elsif image.product.title == 'Stripes Long Sleeve Sweatshirt Dress'
    #     'https://c.cfjump.com/Products/49287/75867849.jpg'
    #   elsif image.product.title == 'High Slit Spaghetti Strap Maxi Party Dress'
    #     'https://c.cfjump.com/Products/49287/75867851.jpg'
    #   end
    # end
  end
end
