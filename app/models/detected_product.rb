class DetectedProduct < ApplicationRecord
  has_attached_file :image, processors: [:cropper], styles: { small: '200' }
  validates_attachment_content_type :image,
                                    content_type: ['image/jpg', 'image/jpeg', 'image/png']
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  belongs_to :image_of_interest

  def cropping?
    [crop_x, crop_y, crop_w, crop_h].all?(&:present?)
  end

  def image_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style))
  end

  def reprocess_image
    image.reprocess!
  end
end
