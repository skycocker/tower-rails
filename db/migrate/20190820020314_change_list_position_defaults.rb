class ChangeListPositionDefaults < ActiveRecord::Migration[5.1]
  def up
    change_column_default(:task_lists, :list_position, 0)
    change_column_default(:tasks,      :list_position, 0)

    TaskList.update_all(list_position: 0)
    Task.update_all(list_position: 0)
  end

  def down
    change_column_default(:task_lists, :list_position, 100)
    change_column_default(:tasks,      :list_position, 100)

    TaskList.update_all(list_position: 100)
    Task.update_all(list_position: 100)
  end
end
