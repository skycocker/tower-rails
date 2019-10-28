class CreateUserDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :user_devices do |t|
      t.integer :user_id,   null: false
      t.string  :fcm_token, null: false

      t.index :user_id
      t.index :fcm_token

      t.index %i(user_id fcm_token), unique: true

      t.timestamps
    end
  end
end
