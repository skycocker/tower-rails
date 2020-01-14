class TaskListUsersController < ApiController
  before_action :authenticate_user!

  api :GET, '/task_lists/:task_list_id/task_list_users', 'Returns users associated to the requested task list'
  param :task_list_id, :number
  def index
    render json: current_user.task_lists.find(params[:task_list_id]).users
  end
end
