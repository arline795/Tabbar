module Paperclip
  class Cropper < Thumbnail
    def transformation_command
      if crop_command
        crop_command + super.join(' ').sub(/ -crop \S+/, '').split(' ')
      else
        super
      end
    end

    def crop_command
      target = @attachment.instance

      if target.cropping?
        crop_w = target.crop_w.to_f / (1 - target.crop_x.to_f / 100)
        crop_h = target.crop_h.to_f / (1 - target.crop_y.to_f / 100)
        [
          '-chop', "#{target.crop_x}x#{target.crop_y}%",
          '-crop', "#{crop_w}x#{crop_h}%+0+0"
        ]
      end
    end
  end
end
