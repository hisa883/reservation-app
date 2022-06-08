class AddDetailsToStores < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :detail, :string
  end
end
