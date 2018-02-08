class AddStoreToUserRoles < ActiveRecord::Migration[5.1]
  def change
    add_reference :user_roles, :store, foreign_key: true
  end
end
