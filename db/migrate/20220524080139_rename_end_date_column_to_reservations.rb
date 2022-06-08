class RenameEndDateColumnToReservations < ActiveRecord::Migration[5.1]
  def change
    rename_column :reservations, :end_date, :end_time
  end
end
