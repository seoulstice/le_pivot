class AddStoreToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :store, foreign_key: true
  end
end
