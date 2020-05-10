class TaskSerializer < ActiveModel::Serializer
  attributes :id, :task_list_id, :content,
             :list_position, :task_note_count,
             :happens_at, :completed_at,
             :latitude, :longitude,
             :created_at, :updated_at

  def task_note_count
    object.task_notes.size
  end
end
