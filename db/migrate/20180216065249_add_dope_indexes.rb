class AddDopeIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :api_keys, [:key, :user_id]
    add_index :user_roles, [:user_id, :store_id], unique: true
    add_index :roles, :name, unique: true
    add_index :stores, :status
    add_index :users, :email, unique: true
  end
end
