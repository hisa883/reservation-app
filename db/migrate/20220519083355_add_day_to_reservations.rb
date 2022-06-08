class AddDayToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :day, :date
    add_column :reservations, :time, :string
  end
end
