class AddTemplateToQuotes < ActiveRecord::Migration[7.1]
  def change
    add_column :quotes, :template, :string
  end
end
