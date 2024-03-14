class AddTextAttributesToQuote < ActiveRecord::Migration[7.1]
  def change
    add_column :quotes, :text_pointsize, :integer
    add_column :quotes, :text_font, :string
    add_column :quotes, :text_fill, :string
  end
end
