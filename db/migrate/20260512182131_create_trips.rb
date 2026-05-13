class CreateTrips < ActiveRecord::Migration[8.1]
  def change
    create_table :trips do |t|
      t.references :user, null: false, foreign_key: true
      t.string :origin
      t.string :destination
      t.datetime :departure_time
      t.integer :price
      t.integer :available_seats
      t.integer :status
      t.string :university

      t.timestamps
    end
  end
end
