class AddHappensAtToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :happens_at, :datetime
  end
end
