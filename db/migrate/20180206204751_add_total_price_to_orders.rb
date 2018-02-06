class AddTotalPriceToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :total_price, :float
  end
end
