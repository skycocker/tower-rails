class TaskListUsersController < ApiController
  before_action :authenticate_user!

  api :GET, '/task_lists/:task_list_id/task_list_users', 'Returns users associated to the requested task list'
  param :task_list_id, :number
  def index
    render json: task_list.users
  end

  api :POST, '/task_lists/:task_list_id/task_list_users', 'Adds a new user to the list (using a provided email address)'
  param :task_list_id, :number
  param :email, String
  def create
    new_user = task_list.users.find_or_initialize_by(email: params[:email])

    if new_user.save
      render json: new_user, status: :created
    else
      render json: { errors: new_user.errors }, status: :unprocessable_entity
    end
  end

  private

  def task_list
    current_user.task_lists.find(params[:task_list_id])
  end
end
