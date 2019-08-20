class Task < ApplicationRecord
  belongs_to :task_list

  validates :task_list, presence: true
  validates :content,   presence: true, length: { maximum: 255 }

  acts_as_list(
    scope:       :task_list,
    column:      :list_position,
    add_new_at:  :bottom,
    top_of_list: 0,
  )

  def complete!
    update!(completed_at: DateTime.current)
  end

  def uncomplete!
    update!(completed_at: nil)
  end
end
