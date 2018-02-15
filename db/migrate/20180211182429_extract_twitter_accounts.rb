class ExtractTwitterAccounts < ActiveRecord::Migration[5.1]
  def change

    remove_columns(:users,
      :uid,
      :screen_name,
      :oauth_token,
      :oauth_token_secret
    )

    create_table :twitter_accounts do |t|
      t.string :uid
      t.string :screen_name
      t.string :oauth_token
      t.string :oauth_token_secret

      t.index :uid, unique: true
    end

  end
end
