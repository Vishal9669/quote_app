class AddPersonIdToQuotes < ActiveRecord::Migration[7.1]
  def change
    add_reference :quotes, :person, foreign_key: true
  end
end
