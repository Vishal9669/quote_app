class CreateQuoteTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :quote_templates do |t|
      t.string :image
      t.integer :quote_id

      t.timestamps
    end
  end
end
