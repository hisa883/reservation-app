class AddTime2ToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :time2, :time
  end
end
