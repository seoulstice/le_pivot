class RemoveColumnsFromItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :image_file_name, :string
    remove_column :items, :image_content_type, :string
    remove_column :items, :image_file_size, :string
    remove_column :items, :image_updated_at, :datetime
  end
end
