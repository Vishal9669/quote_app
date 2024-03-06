class Quote < ApplicationRecord
  has_one_attached :thumbnail
  belongs_to :person

  validates :content, presence: true, length: { maximum: 1000 }
  validates :author, presence: true, length: { maximum: 100 }
  validates :person_id, presence: true
end
