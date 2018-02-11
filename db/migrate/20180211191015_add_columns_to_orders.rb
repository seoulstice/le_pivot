class AddColumnsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :image_file_name, :string
    add_column :orders, :image_content_type, :string
    add_column :orders, :image_file_size, :string
    add_column :orders, :image_updated_at, :string
  end
end
