class AddCategoryToQuote < ActiveRecord::Migration[7.1]
  def change
    add_column :quotes, :category, :string
  end
end
