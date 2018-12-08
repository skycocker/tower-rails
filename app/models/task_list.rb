class TaskList < ApplicationRecord
  validates :name, presence: true

  has_many :task_list_users
  has_many :users, through: :task_list_users

  has_many :tasks
end
