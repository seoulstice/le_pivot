class AddColumnToItems < ActiveRecord::Migration[5.1]
  def change
      if column_exists? :items, :image
        remove_column :items, :image, :string
      end

      add_column :items, :image, :string
  end
end
