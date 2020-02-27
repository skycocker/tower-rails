# frozen_string_literal: true

class TaskListInvitationWorker
  DEFAULT_MESSAGE  = 'You have been invited!'
  DETAILED_MESSAGE = 'You have been invited by'

  include Sidekiq::Worker

  attr_reader :task_list_id, :receiver_id, :invitor_id

  def perform(task_list_id, receiver_id, invitor_id)
    @task_list_id = task_list_id
    @receiver_id  = receiver_id
    @invitor_id   = invitor_id

    return if task_list.blank?
    return if receiver.blank?

    PushNotification.new(
      user_ids: [receiver.id],
      title:    task_list.name,
      content:  message,
      data: {
        task: {
          task_list_id: task_list.id,
          task_id:      0, # this is a hack in case you didn't notice
        },
      },
    ).send
  end

  private

  def message
    return DEFAULT_MESSAGE if invitor.blank?
    "#{DETAILED_MESSAGE} #{invitor.email}!"
  end

  def task_list
    @task_list ||= TaskList.find_by(id: task_list_id)
  end

  def receiver
    @receiver ||= User.find_by(id: receiver_id)
  end

  def invitor
    @invitor ||= User.find_by(id: invitor_id)
  end
end
