class RemoveLogoPathFromQuotes < ActiveRecord::Migration[7.1]
  def change
    remove_column :quotes, :logo_path, :string
  end
end
