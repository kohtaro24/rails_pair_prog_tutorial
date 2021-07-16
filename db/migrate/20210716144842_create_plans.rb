class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :title, limit: 255, null: false
      t.integer :price, null: false
    end
  end
end
