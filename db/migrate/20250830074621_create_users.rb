class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.citext :email, null: false
      t.string :display_name
      t.st_point :home_area, geographic: true
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
