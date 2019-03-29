class ProductImage < ActiveRecord::Base
  belongs_to :product

  has_attached_file :product_image, styles: { large: '600', medium: '250' }
  validates_attachment_content_type :product_image, content_type: /\Aimage\/.*\Z/

  has_attached_file :cropped_image, styles: { large: '600', medium: '250' }
  validates_attachment_content_type :cropped_image, content_type: /\Aimage\/.*\Z/

  def url(size)
    product_image.exists? ? product_image.url(size) : full_direct_url
  end

  def absolute_url
    large_url = url(:large)
    return large_url if large_url.starts_with?('http') || large_url.starts_with?('//')
    ActionController::Base.asset_host.to_s + large_url
  end

  alias image_url absolute_url

  def full_direct_url
    if direct_url.present? && direct_url.starts_with?('//')
      protocol = product.redirect_url.split('://').first
      "#{protocol}:#{direct_url}"
    else
      direct_url
    end
  end

  def upload_to_s3!
    self.product_image = full_direct_url
    save!
  end
end
