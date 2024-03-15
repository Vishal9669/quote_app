class AddTemplateSizeToQuotes < ActiveRecord::Migration[7.1]
  def change
    add_column :quotes, :template_size, :string
  end
end
