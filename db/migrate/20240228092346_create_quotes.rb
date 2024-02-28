class CreateQuotes < ActiveRecord::Migration[7.1]
  def change
    create_table :quotes do |t|
      t.text :content
      t.string :author

      t.timestamps
    end
  end
end
