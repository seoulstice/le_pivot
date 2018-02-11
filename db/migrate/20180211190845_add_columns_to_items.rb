class AddColumnsToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :image_file_name, :string
    add_column :items, :image_content_type, :string
    add_column :items, :image_file_size, :string
    add_column :items, :image_updated_at, :string
  end
end
