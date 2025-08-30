class CreatePandalImages < ActiveRecord::Migration[7.1]
  def change
    create_table :pandal_images do |t|
      t.references :pandal, null: false, foreign_key: true
      t.string :url, null: false
      t.string :caption
      t.integer :sort_order, default: 0
      t.timestamps
    end
  end
end
