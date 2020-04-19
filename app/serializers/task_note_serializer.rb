class TaskNoteSerializer < ActiveModel::Serializer
  attributes :id, :task_id, :content
end
