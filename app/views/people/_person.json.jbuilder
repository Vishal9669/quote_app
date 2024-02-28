json.extract! person, :id, :name, :image, :created_at, :updated_at
json.url person_url(person, format: :json)
