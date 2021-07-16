class CreateCalls < ActiveRecord::Migration[5.2]
  def change
    create_table :calls do |t|
      t.references :contract, index: true, foreign_key: true
      t.string :from, limit: 255, null: false
      t.string :to, limit: 255, null: false
      t.integer :duration, null: false
      t.integer :direction, limit: 1, null: false

      t.timestamps
    end
  end
end
