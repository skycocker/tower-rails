class AddCompletedAtToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :completed_at, :datetime
    add_index  :tasks, :completed_at
  end
end
