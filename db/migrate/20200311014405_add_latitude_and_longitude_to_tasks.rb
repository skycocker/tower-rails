class AddLatitudeAndLongitudeToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :latitude,  :decimal, precision: 10, scale: 6
    add_column :tasks, :longitude, :decimal, precision: 10, scale: 6

    add_index :tasks, %i(latitude longitude)
  end
end
