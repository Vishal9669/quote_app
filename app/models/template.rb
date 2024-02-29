class Template < ApplicationRecord
  has_many_attached :pictures

  validate :pictures_presence
  validate :pictures_content_type_and_size

  private

  def pictures_presence
    errors.add(:pictures, "can't be blank") unless pictures.attached?
  end

  def pictures_content_type_and_size
    if pictures.attached?
      pictures.each do |picture|
        if !picture.content_type.in?(%w(image/jpeg image/png))
          errors.add(:pictures, 'must be a JPEG or PNG')
        elsif picture.blob.byte_size > 5.megabytes
          errors.add(:pictures, 'size exceeds 5MB')
        end
      end
    end
  end
end
