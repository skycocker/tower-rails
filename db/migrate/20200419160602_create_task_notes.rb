class CreateTaskNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :task_notes do |t|
      t.integer :task_id, null: false
      t.text    :content

      t.index :task_id

      t.timestamps
    end
  end
end
