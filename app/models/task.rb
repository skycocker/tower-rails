class Task < ApplicationRecord
  belongs_to :task_list

  validates :task_list, presence: true
  validates :content,   presence: true, length: { maximum: 255 }

  def complete!
    update!(completed_at: DateTime.current)
  end

  def uncomplete!
    update!(completed_at: nil)
  end
end
