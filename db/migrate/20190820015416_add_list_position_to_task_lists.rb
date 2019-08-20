class AddListPositionToTaskLists < ActiveRecord::Migration[5.1]
  def change
    add_column :task_lists, :list_position, :integer, default: 100
    add_index  :task_lists, :list_position
  end
end
