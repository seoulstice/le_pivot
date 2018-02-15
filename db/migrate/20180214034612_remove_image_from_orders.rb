class RemoveImageFromOrders < ActiveRecord::Migration[5.1]
  def up
    remove_column :orders, :image
  end

  def down
    add_column :orders, :image, :string
  end
end
