# frozen_string_literal: true

class TasksController < ApiController
  QUERY_INCLUDES = %w(
    task_notes
  ).freeze

  before_action :authenticate_user!

  api :GET, '/task_lists/:task_list_id/tasks', 'Returns tasks from requested task list'
  param :task_list_id, :number
  def index
    render(
      json:    task_list.tasks.includes(QUERY_INCLUDES).order('list_position asc, id asc'),
      include: QUERY_INCLUDES,
    )
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
      param :latitude,      String
      param :longitude,     String
      param :list_position, :number, allow_blank: true
    end
  end

  api :POST, '/task_lists/:task_list_id/tasks', 'Creates a new task in given list'
  param :task_list_id, :number
  param_group :task
  def create
    new_task = task_list.tasks.includes(QUERY_INCLUDES).new(task_params)

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
      render json: task, status: 200
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
  def uncomplete
    if task.uncomplete!
      return head(204)
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  api :POST, '/task_lists/:task_list_id/tasks/:task_id/change_position', 'Changes the item position to the provided value'
  param :task_list_id,  :number
  param :task_id,       :number
  param :list_position, :number
  def change_position
    task.insert_at!(params[:list_position].to_i)
    head(204)
  end

  api :POST, '/task_lists/:task_list_id/tasks/:task_id/move', 'Changes the list the provided task belongs to'
  param :task_list_id, :number
  param :task_id,      :number
  param :new_list_id,  :number
  def move
    new_list = current_user.task_lists.find(params[:new_list_id].to_i)

    if task.update(task_list: new_list)
      render json: task, status: 200
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
    @task_list ||= current_user.task_lists.find(params[:task_list_id])
  end

  def task_params
    params.require(:task).permit(:content, :happens_at, :list_position, :latitude, :longitude)
  end

  def task
    @task ||= task_list.tasks.includes(QUERY_INCLUDES).find(params[:id] || params[:task_id])
  end
end
