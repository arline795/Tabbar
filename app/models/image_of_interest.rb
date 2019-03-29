class ImageOfInterest < ApplicationRecord
  belongs_to :user
  has_one :cropped_product, dependent: :destroy

  has_attached_file :image, styles: { large: '600', medium: '250', thumb: '100' }
  validates_attachment_content_type :image,
                                    content_type: ['image/jpg', 'image/jpeg', 'image/png']

  before_create :add_uuid

  has_many :detected_products

  def add_uuid
    self.uuid = SecureRandom.uuid
  end
end
