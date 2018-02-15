class AddNewColumnToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :total_price_with_shipping, :float
  end
end
