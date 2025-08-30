class CreatePandalNearbies < ActiveRecord::Migration[7.1]
  def change
    create_table :pandal_nearbies, id: false do |t|
      t.references :pandal, null: false, foreign_key: true
      t.string :poi_type, null: false
      t.bigint :poi_id, null: false
      t.integer :distance_m
    end
    add_index :pandal_nearbies, [:pandal_id, :poi_type, :poi_id], unique: true, name: "idx_pandal_nearby_unique"
  end
end
