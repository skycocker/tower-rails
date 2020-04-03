class TaskList < ApplicationRecord
  strip_attributes only: %i(name)

  has_many :task_list_users, dependent: :destroy
  has_many :users, through: :task_list_users

  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks

  validates :name, presence: true

  before_create :set_list_position

  acts_as_list(
    column:      :list_position,
    add_new_at:  :bottom,
    top_of_list: 0,
  )

  private

  def set_list_position
    self.list_position = user.task_lists.order('list_position desc').first.list_position.next
  end
end
