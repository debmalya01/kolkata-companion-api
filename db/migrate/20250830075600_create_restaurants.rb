class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.references :venue, null: false, foreign_key: true
      t.string :rtype # Restaurant/Cafe/StreetFood
      t.string :price_band # Budget/Mid/Premium
      t.string :cuisine
      t.decimal :rating, precision: 5, scale: 2
      t.time :opens_at
      t.time :closes_at
      t.timestamps
    end
  end
end
