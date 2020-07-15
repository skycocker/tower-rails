class TaskListUser < ApplicationRecord
  attr_accessor :invitor

  belongs_to :task_list
  belongs_to :user

  validates :task_list, presence: true
  validates :user,      presence: true, uniqueness: { scope: :task_list }

  after_create :notify_user

  private

  def notify_user
    return if user.id == invitor.try(:id)
    return if invitor.blank?

    TaskListInvitationWorker.perform_async(task_list.id, user.id, invitor.try(:id))
  end
end
