class AddDefaultStatusOnOrders < ActiveRecord::Migration[5.1]
  def up
    change_column :orders, :status, :integer, default: 0
  end

  def down
    change_column :orders, :status, :integer
  end
end
