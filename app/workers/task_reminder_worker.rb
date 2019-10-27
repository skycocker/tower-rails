# frozen_string_literal: true

class TaskReminderWorker
  include Sidekiq::Worker

  attr_reader :task_id

  def perform(task_id)
    @task_id = task_id

    return if task.blank?

    return if task.happens_at > (DateTime.current + 1.minute)
    return if task.happens_at < (DateTime.current - 1.minute)

    PushNotification.new(
      task.task_list.users.ids,
      task.content,
      task.task_list.name,
    )
  end

  private

  def task
    @task ||= Task.find_by(id: task_id)
  end
end
