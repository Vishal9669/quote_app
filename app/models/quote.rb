class Quote < ApplicationRecord
  has_one_attached :thumbnail
  belongs_to :person

  validates :content, presence: true, length: { maximum: 500 }
  validates :template, presence: true
end
