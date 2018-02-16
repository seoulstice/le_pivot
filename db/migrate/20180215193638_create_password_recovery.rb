class CreatePasswordRecovery < ActiveRecord::Migration[5.1]
  def change
    create_table :password_recoveries do |t|
      t.string :code
      t.references :user, foreign_key: true
    end
  end
end
