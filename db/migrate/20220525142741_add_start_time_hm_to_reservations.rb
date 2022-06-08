class AddStartTimeHmToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :start_time_h, :string
    add_column :reservations, :start_time_m, :string
  end
end
