class TaskListUserSerializer < ActiveModel::Serializer
  attributes :id, :task_list_id,
             :created_at, :updated_at

  belongs_to :user
end
