class AddStatusToStores < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :status, :integer, default: 0
  end
end
