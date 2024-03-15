class AddLogoPositionToQuotes < ActiveRecord::Migration[7.1]
  def change
    add_column :quotes, :logo_position, :string
  end
end
