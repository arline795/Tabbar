class ProductCoordinatesNotFoundError < StandardError
  def initialize(msg = 'No products were found in image')
    super
  end
end
