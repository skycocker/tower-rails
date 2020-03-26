class ResetPasswordController < ApiController
  api :POST, '/send_reset_password_instructions', 'Sends reset password instructions email to the user'
  param :email, String
  def send_reset_password_instructions
    User.find_by!(email: params[:email]).send_reset_password_instructions
    head(:ok)
  end

  def reset_password
    redirect_to("tower://reset_password?token=#{params[:token]}")
  end
end
