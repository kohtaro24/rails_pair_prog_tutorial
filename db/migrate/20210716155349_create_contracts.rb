class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.references :plan, index: true, foreign_key: true
      t.string :name, limit: 255, null: false
      t.integer :users_quantity, null: false

      t.timestamps
    end
  end
end
