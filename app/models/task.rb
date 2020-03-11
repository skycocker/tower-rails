# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :task_list

  strip_attributes only: %i(content)

  validates :task_list, presence: true
  validates :content,   presence: true, length: { maximum: 255 }

  after_commit :schedule_reminder, on: %i(create update)

  acts_as_list(
    scope:       :task_list,
    column:      :list_position,
    add_new_at:  :bottom,
    top_of_list: 0,
  )

  reverse_geocoded_by :latitude, :longitude

  def complete!
    update!(completed_at: DateTime.current)
  end

  def uncomplete!
    update!(completed_at: nil)
  end

  private

  def schedule_reminder
    return if happens_at.blank?
    return unless saved_change_to_attribute?('happens_at')

    TaskReminderWorker.perform_at(happens_at, id)
  end
end
