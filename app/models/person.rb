class Person < ApplicationRecord
  has_one_attached :image
  has_many :quotes

  validates :name, presence: true, length: { maximum: 100 }
  validate :image_presence
  validate :image_content_type

  private

  def image_presence
    errors.add(:image, "can't be blank") unless image.attached?
  end

  def image_content_type
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/png))
      errors.add(:image, 'must be a JPEG or PNG')
    elsif image.attached? && image.blob.byte_size > 5.megabytes
      errors.add(:image, 'size exceeds 5MB')
    end
  end
end
