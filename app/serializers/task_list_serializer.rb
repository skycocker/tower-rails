class TaskListSerializer < Panko::Serializer
  attributes :id, :name, :list_position,
             :pending_count,
             :created_at, :updated_at

  has_many :task_list_users, each_serializer: TaskListUserSerializer

  def pending_count
    object.pending_tasks.count
  end
end
