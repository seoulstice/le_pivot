class CreateTwilio < ActiveRecord::Migration[5.1]
  def change
    create_table :twilios do |t|
      t.string :code
      t.references :user, foreign_key: true
    end
  end
end
