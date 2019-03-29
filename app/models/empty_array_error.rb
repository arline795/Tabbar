class EmptyArrayError < StandardError
  def initialize(msg = 'Array is empty')
    super
  end
end
