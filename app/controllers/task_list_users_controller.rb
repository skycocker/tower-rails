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
    if (params[:email] =~ Devise.email_regexp).blank?
      return render json: { errors: ['invalid email format'] }, status: :unprocessable_entity
    end

    new_user = task_list.task_list_users
                        .joins(:user)
                        .where(users: { email: params[:email] })
                        .first

    if new_user.blank?
      new_user = task_list.task_list_users
                          .new(
                            user:    User.find_by!(email: params[:email]),
                            invitor: current_user,
                          )
    end

    if new_user.save
      render json: new_user.user, status: :created
    else
      render json: { errors: new_user.errors }, status: :unprocessable_entity
    end
  end

  api :DELETE, '/task_lists/:task_list_id/task_list_users', 'Deletes provided user from the list (using the task_list_user_id)'
  param :task_list_id, :number
  def destroy
    if (params[:email] =~ Devise.email_regexp).blank?
      return render json: { errors: ['invalid email format'] }, status: :unprocessable_entity
    end

    task_list.task_list_users
             .joins(:user)
             .where(users: { email: params[:email] })
             .first
             .destroy!

    head(:no_content)
  end

  private

  def task_list
    current_user.task_lists.find(params[:task_list_id])
  end
end
