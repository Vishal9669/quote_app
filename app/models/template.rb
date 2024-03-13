class Template < ApplicationRecord
  has_one_attached :picture

  validate :picture_presence
  validate :picture_content_type_and_size

  private

  def picture_presence
    errors.add(:picture, "can't be blank") unless picture.attached?
  end

  def picture_content_type_and_size
    if picture.attached?
      if !picture.content_type.in?(%w(image/jpeg image/png))
        errors.add(:picture, 'must be a JPEG or PNG')
      elsif picture.blob.byte_size > 5.megabytes
        errors.add(:picture, 'size exceeds 5MB')
      end
    end
  end
end
