class TasksController < ApiController
  before_action :authenticate_user!

  api :GET, '/task_lists/:task_list_id/tasks', 'Returns tasks from requested task list'
  param :task_list_id, :number
  param :page, :number, 'Starts from 1. Will return items in bulks of 25, starting from the most recent.'
  def index
    render json: task_list.tasks.page(params[:page])
  end

  api :GET, '/task_lists/:task_list_id/tasks/:id', 'Returns requested task details'
  param :task_list_id, :number
  param :id,           :number
  def show
    render json: task_list.tasks.find(params[:id])
  end

  def_param_group :task do
    param :task, Hash do
      param :content,       String
      param :happens_at,    String
      param :list_position, :number, allow_blank: true
    end
  end

  api :POST, '/task_lists/:task_list_id/tasks', 'Creates a new task in given list'
  param :task_list_id, :number
  param_group :task
  def create
    new_task = task_list.tasks.new(task_params)

    if new_task.save
      render json: new_task, status: 201
    else
      render json: { errors: new_task.errors }, status: 422
    end
  end

  api :PUT, '/task_lists/:task_list_id/tasks/:id', 'Updates the given task'
  param :task_list_id, :number
  param :id,           :number
  param_group :task
  def update
    if task.update(task_params)
      render json: task, status: 201
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  api :POST, '/task_lists/:task_list_id/tasks/:task_id/complete', 'Marks given task as completed'
  param :task_list_id, :number
  param :task_id,      :number
  def complete
    if task.complete!
      return head(204)
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  api :POST, '/task_lists/:task_list_id/tasks/:task_id/uncomplete', 'Marks given task as uncompleted'
  param :task_list_id, :number
  param :task_id,      :number
  def complete
    if task.uncomplete!
      return head(204)
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  api :DELETE, '/task_lists/:task_list_id/tasks/:id', 'Destroys the given task'
  param :task_list_id, :number
  param :id,           :number
  def destroy
    task.destroy!
    head(204)
  end

  private

  def task_list
    current_user.task_lists.find(params[:task_list_id])
  end

  def task_params
    params.require(:task).permit(:content, :happens_at, :list_position)
  end

  def task
    task_list.tasks.find(params[:id] || params[:task_id])
  end
end
