class Person < ApplicationRecord
  has_one_attached :image
  has_many :quotes
end
