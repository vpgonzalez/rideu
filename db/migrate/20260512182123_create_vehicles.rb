class CreateVehicles < ActiveRecord::Migration[8.1]
  def change
    create_table :vehicles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :brand
      t.string :model
      t.integer :year
      t.string :plate
      t.string :color
      t.integer :seats

      t.timestamps
    end
  end
end
