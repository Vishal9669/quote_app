class AddPersonRefToQuotes < ActiveRecord::Migration[7.1]
  def change
    add_reference :quotes, :person, null: false, foreign_key: true
  end
end
