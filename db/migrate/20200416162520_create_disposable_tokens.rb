class CreateDisposableTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :disposable_tokens do |t|
      t.string   :value,      null: false
      t.datetime :expires_at, null: false

      t.index :value
      t.index :expires_at
      t.index %i(value expires_at)

      t.timestamps
    end
  end
end
