class AddSlugToChatroom < ActiveRecord::Migration[5.1]
  def change
    add_column :chatrooms, :slug, :string
    add_index :chatrooms, :slug, unique: true
  end
end
