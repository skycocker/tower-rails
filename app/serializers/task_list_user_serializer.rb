class TaskListUserSerializer < Panko::Serializer
  attributes :id, :task_list_id,
             :created_at, :updated_at

  has_one :user, serializer: UserSerializer
end
