class AddColumnToOrders < ActiveRecord::Migration[5.1]
  def change
    if column_exists? :orders, :image
      remove_column :orders, :image, :string
    end
    add_column :orders, :image, :string
  end
end
