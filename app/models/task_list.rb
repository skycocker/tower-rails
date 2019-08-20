class TaskList < ApplicationRecord
  validates :name, presence: true

  has_many :task_list_users, dependent: :destroy
  has_many :users, through: :task_list_users

  has_many :tasks, dependent: :destroy

  acts_as_list(
    column:      :list_position,
    add_new_at:  :bottom,
    top_of_list: 0,
  )
end
