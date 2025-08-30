class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :pandal, null: false, foreign_key: true
      t.string :title, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at
      t.string :event_type
      t.text :notes
      t.timestamps
    end
    add_index :events, :starts_at
  end
end
