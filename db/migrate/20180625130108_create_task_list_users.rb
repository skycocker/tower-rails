class CreateTaskListUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :task_list_users do |t|
      t.integer :task_list_id, null: false
      t.integer :user_id,      null: false

      t.index %i(task_list_id user_id), unique: true

      t.timestamps
    end
  end
end
