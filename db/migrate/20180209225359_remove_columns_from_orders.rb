class RemoveColumnsFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :image_file_name, :string
    remove_column :orders, :image_content_type, :string
    remove_column :orders, :image_file_size, :string
    remove_column :orders, :image_updated_at, :datetime
  end
end
