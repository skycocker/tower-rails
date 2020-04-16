class DisposableTokensController < ApiController
  before_action :authenticate_user!, only: %i(sign_in_with)

  def create
    disposable_token = DisposableToken.create!
    render json: disposable_token, status: :created
  end

  def sign_in_with
    return head(422) if params[:token].blank?

    DisposableToken.use!(
      value: params[:token],
      user:  User.find(current_user.id),
    )

    head(204)
  rescue ActiveRecord::RecordNotFound
    head(404)
  end
end
