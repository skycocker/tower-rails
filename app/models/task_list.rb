class TaskList < ApplicationRecord
  validates :name, presence: true

  has_many :task_list_users
  has_many :users, through: :task_list_users

  has_many :tasks

  acts_as_list(
    column:      :list_position,
    add_new_at:  :top,
    top_of_list: 0,
  )
end
