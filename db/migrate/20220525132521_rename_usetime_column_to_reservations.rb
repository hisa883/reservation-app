class RenameUsetimeColumnToReservations < ActiveRecord::Migration[5.1]
  def change
    rename_column :reservations, :usetime, :use_time
  end
end
