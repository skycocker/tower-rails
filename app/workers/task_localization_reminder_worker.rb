# frozen_string_literal: true

class TaskLocalizationReminderWorker
  include Sidekiq::Worker

  attr_reader :user_id

  def perform(user_id, latitude, longitude)
    @user_id = user_id

    Task
      .where(task_list_id: user.task_lists.ids)
      .near([latitude, longitude], 1, units: :km)
      .each(&method(:send_notification_for))
  end

  private

  def user
    @user ||= User.find(user_id)
  end

  def send_notification_for(task)
    PushNotification.new(
      user_ids: [user_id],
      title:    task.content,
      content:  task.task_list.name,
      data: {
        task: {
          task_list_id: task.task_list.id,
          task_id:      task.id,
        },
      },
      overrides: {
        click_action: 'task.category',
      },
    ).send
  end
end
