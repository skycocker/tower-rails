class TaskListsController < ApiController
  QUERY_INCLUDES = %w(
    task_list_users
    task_list_users.user
  ).freeze

  before_action :authenticate_user!

  api :GET, '/task_lists', 'Returns current user task lists'
  def index
    render(
      json:    current_user.task_lists.includes(task_list_users: :user).order('list_position asc, id asc'),
      include: QUERY_INCLUDES,
    )
  end

  api :GET, '/task_lists/:id', 'Returns given task list details'
  param :id, :number
  def show
    render(
      json:    task_list,
      include: QUERY_INCLUDES,
    )
  end

  def_param_group :task_list do
    param :task_list, Hash do
      param :name, String
    end
  end

  api :POST, '/task_lists', 'Creates a new task list'
  param_group :task_list
  def create
    new_list = current_user.task_lists.new(task_list_params)
    new_list.users << current_user

    if new_list.save
      render json: new_list, status: 201, include: QUERY_INCLUDES
    else
      render json: { errors: new_list.errors }, status: 422
    end
  end

  api :PUT, '/task_lists/:id', 'Updates given task list'
  param :id, :number
  param_group :task_list
  def update
    if task_list.update(task_list_params)
      render json: task_list, include: QUERY_INCLUDES
    else
      render json: { errors: task_list.errors }, status: 422
    end
  end

  api :POST, '/task_lists/:task_list_id/change_position', 'Changes the list position to the provided value'
  param :id,            :number
  param :list_position, :number
  def change_position
    task_list.insert_at!(params[:list_position].to_i)
    head(204)
  end

  api :DELETE, '/task_lists/:id', 'Destroys given task list'
  param :id, :number
  def destroy
    task_list.destroy!
    head(204)
  end

  private

  def task_list_params
    params.require(:task_list).permit(:name)
  end

  def task_list
    current_user.task_lists.find(params[:task_list_id] || params[:id])
  end
end
