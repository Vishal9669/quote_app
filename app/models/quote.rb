class Quote < ApplicationRecord
  belongs_to :person
  has_many :quote_templates

  validates :content, presence: true, length: { maximum: 1000 }
  validates :author, presence: true, length: { maximum: 100 }
  validates :person_id, presence: true
end
