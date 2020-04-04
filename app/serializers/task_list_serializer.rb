class TaskListSerializer < ActiveModel::Serializer
  attributes :id, :name, :list_position,
             :created_at, :updated_at

  has_many :task_list_users
end
