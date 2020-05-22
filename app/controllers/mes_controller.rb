class MesController < ApiController
  before_action :authenticate_user!

  api :GET, '/me', 'Returns current_user object'
  def show
    render json: current_user
  end

  api :PATCH, '/me', 'Updates current_user object'
  param :email,    String, required: false
  param :password, String, required: false
  def update
    user = User.find(current_user.id)

    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  api :POST, '/register_device', 'Registers a new user device'
  param :fcm_token, String
  def register_device
    if params[:fcm_token].blank?
      return head(:unprocessable_entity)
    end

    device = current_user
               .user_devices
               .find_or_create_by(fcm_token: params[:fcm_token])

    if device.save
      render json: device, status: :ok
    else
      render json: { errors: device.errors }, status: unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
