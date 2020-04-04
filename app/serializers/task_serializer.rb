class TaskSerializer < ActiveModel::Serializer
  attributes :id, :task_list_id, :content,
             :list_position,
             :happens_at, :completed_at,
             :latitude, :longitude,
             :created_at, :updated_at
end
