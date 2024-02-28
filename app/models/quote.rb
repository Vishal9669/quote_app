class Quote < ApplicationRecord
  belongs_to :person
  has_many :quote_templates
end
