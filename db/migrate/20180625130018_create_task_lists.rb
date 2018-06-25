class CreateTaskLists < ActiveRecord::Migration[5.1]
  def change
    create_table :task_lists do |t|
      t.string :name, null: false

      t.index :name

      t.timestamps
    end
  end
end
