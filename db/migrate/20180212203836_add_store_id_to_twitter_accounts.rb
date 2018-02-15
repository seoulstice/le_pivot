class AddStoreIdToTwitterAccounts < ActiveRecord::Migration[5.1]
  def change
    add_reference :twitter_accounts, :store, foreign_key: true
  end
end
