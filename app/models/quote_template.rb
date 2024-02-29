class QuoteTemplate < ApplicationRecord
  has_one_attached :image
  belongs_to :quote
end
