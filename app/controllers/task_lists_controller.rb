class TaskListsController < ApiController
  before_action :authenticate_user!

  api :GET, '/task_lists', 'Returns current user task lists'
  param :page, :number, 'Starts from 1. Will return items in bulks of 25, starting from the most recent.'
  def index
    render json: current_user.task_lists.page(params[:page])
  end

  api :GET, '/task_lists/:id', 'Returns given task list details'
  param :id, :number
  def show
    render json: task_list
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

    if new_list.save
      render json: new_list, status: 201
    else
      render json: { errors: new_list.errors }, status: 422
    end
  end

  api :PUT, '/task_lists/:id', 'Updates given task list'
  param :id, :number
  param_group :task_list
  def update
    if task_list.update(task_list_params)
      render json: task_list
    else
      render json: { errors: task_list.errors }, status: 422
    end
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
    current_user.task_lists.find(params[:id])
  end
end