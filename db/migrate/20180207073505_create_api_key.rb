class CreateApiKey < ActiveRecord::Migration[5.1]
  def change
    create_table :api_keys do |t|

      t.string     :key,  null: false, index: { unique: true }
      t.belongs_to :user, null: true,  index: { unique: true }

    end
  end
end
