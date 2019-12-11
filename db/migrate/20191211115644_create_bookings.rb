class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :sport
      t.string :city
      t.string :date
      t.string :starting_hour
      t.string :duration
      t.string :price
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
