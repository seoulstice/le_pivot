class CreateMessage < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :chatroom, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
