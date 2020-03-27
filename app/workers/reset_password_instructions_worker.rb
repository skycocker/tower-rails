class ResetPasswordInstructionsWorker
  include Sidekiq::Worker

  def perform(user_id)
    User.find(user_id).send_reset_password_instructions
  end
end

