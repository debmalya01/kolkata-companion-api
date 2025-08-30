class CreatePandals < ActiveRecord::Migration[7.1]
  def change
    create_table :pandals do |t|
      t.references :venue, null: false, foreign_key: true
      t.integer :year, null: false
      t.string :club_name, null: false
      t.string :theme_title
      t.text :description
      t.string :category
      t.datetime :expected_peak_start
      t.datetime :expected_peak_end
      t.decimal :rating_estimate, precision: 5, scale: 2
      t.integer :crowd_level
      t.timestamps
    end
    add_index :pandals, [:venue_id, :year], unique: true
  end
end
