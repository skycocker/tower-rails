class MesController < ApiController
  before_action :authenticate_user!

  def register_device
    if params[:fcm_token].blank?
      return head(422)
    end

    device = current_user
               .user_devices
               .find_or_create_by(fcm_token: params[:fcm_token])

    if device.save
      render json: device, status: 200
    else
      render json: { errors: device.errors }, status: 422
    end
  end
end
