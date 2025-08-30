class CreateVenues < ActiveRecord::Migration[7.1]
  def change
    create_table :venues do |t|
      t.string :name, null: false
      t.string :address
      t.string :area
      t.st_point :location, geographic: true, null: false
      t.string :plus_code
      t.string :google_place_id
      t.timestamps
    end
    add_index :venues, :location, using: :gist
  end
end
