class CreatePlanStops < ActiveRecord::Migration[7.1]
  def change
    create_table :plan_stops do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :pandal, null: false, foreign_key: true
      t.integer :stop_order, null: false
      t.datetime :target_arrival
      t.datetime :target_departure
      t.string :chosen_mode # Walk/Auto/Metro/Cab/Bus
      t.integer :est_travel_min
      t.decimal :est_travel_cost, precision: 8, scale: 2
      t.text :notes
      t.timestamps
    end
    add_index :plan_stops, [:plan_id, :stop_order], unique: true
  end
end
