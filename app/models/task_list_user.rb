class TaskListUser < ApplicationRecord
  attr_accessor :invitor

  belongs_to :task_list
  belongs_to :user

  validates :task_list, presence: true
  validates :user,      presence: true, uniqueness: { scope: :task_list }

  after_commit :notify_user, on: :create

  private

  def notify_user
    TaskListInvitationWorker.perform_async(id, user.id, invitor.try(:id))
  end
end
