class TaskList < ApplicationRecord
  strip_attributes only: %i(name)

  has_many :task_list_users, dependent: :destroy
  has_many :users, through: :task_list_users

  has_many :tasks, dependent: :destroy
  has_many :pending_tasks, -> { pending }, class_name: 'Task'

  accepts_nested_attributes_for :tasks

  validates :name, presence: true

  acts_as_list(
    column:      :list_position,
    add_new_at:  :bottom,
    top_of_list: 0,
  )
end
