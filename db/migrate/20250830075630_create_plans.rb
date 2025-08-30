class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.date :visit_date, null: false
      t.decimal :budget_cap, precision: 10, scale: 2
      t.timestamps
    end
  end
end
