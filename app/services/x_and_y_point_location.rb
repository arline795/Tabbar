class XAndYPointLocation
  def self.call(corordinate)
    width = corordinate[3].to_i - corordinate[1].to_i
    height = corordinate[2].to_i - corordinate[0].to_i

    x_corrdinate = corordinate[1].to_i + (width / 2).to_i
    y_corrdinate = corordinate[0].to_i + (height / 2).to_i

    [x_corrdinate, y_corrdinate]
  end
end
