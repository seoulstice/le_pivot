class CreateChatroom < ActiveRecord::Migration[5.1]
  def change
    create_table :chatrooms do |t|
      t.string :topic
    end
  end
end
