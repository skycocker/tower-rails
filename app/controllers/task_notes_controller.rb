class TaskNotesController < ApiController
  before_action :authenticate_user!

  api :GET, '/task_lists/:task_list_id/tasks/:task_id/task_notes/last', 'Returns the last task note belonging to the requested task'
  param :task_list_id, :number
  param :task_id,      :number
  def get_last
    render json: TaskNoteSerializer.new.serialize_to_json(task_note)
  end

  api :PATCH, '/task_lists/:task_list_id/tasks/:task_id/task_notes/last', 'Updates the last task note belonging to the requested task'
  param :task_list_id, :number
  param :task_id,      :number
  def update_last
    task_note.assign_attributes(task_note_params)

    if task_note.save
      render json: TaskNoteSerializer.new.serialize_to_json(task_note), status: :ok
    else
      render json: { errors: task_note.errors }, status: :unprocessable_entity
    end
  end

  private

  def task_note
    @task_note ||= task.task_notes.order('id desc').first_or_initialize
  end

  def task_note_params
    params.require(:task_note).permit(:content)
  end

  def task
    @task ||= task_list.tasks.find(params[:task_id])
  end

  def task_list
    @task_list ||= current_user.task_lists.find(params[:task_list_id])
  end
end
