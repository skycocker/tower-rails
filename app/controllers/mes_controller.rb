class MesController < ApiController
  before_action :authenticate_user!

  def update
    if current_user.update(me_params)
      render json: current_user
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  private

  def me_params
    params.require(:me).permit(:fcm_token)
  end
end
