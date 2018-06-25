class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.integer :task_list_id,  null: false
      t.string  :content,       null: false
      t.integer :list_position, default: 100

      t.index :task_list_id
      t.index :list_position

      t.timestamps
    end
  end
end
