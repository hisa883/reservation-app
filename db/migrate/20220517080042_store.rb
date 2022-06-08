class Store < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :number_of_rooms, :integer
  end
end
