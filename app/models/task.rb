class Task < ApplicationRecord
  belongs_to :task_list

  validates :task_list, presence: true
  validates :content,   presence: true, length: { maximum: 255 }
end