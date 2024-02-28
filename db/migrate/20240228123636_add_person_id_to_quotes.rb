class AddPersonIdToQuotes < ActiveRecord::Migration[7.1]
  def change
    add_column :quotes, :person_id, :integer
  end
end
