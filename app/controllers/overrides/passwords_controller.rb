class Overrides::PasswordsController < DeviseTokenAuth::PasswordsController
  def edit
    super do |resource|
      token_data = @resource.create_token

      @resource.save!

      return render json: {
        'client':       token_data.client,
        'access-token': token_data.token,
        'uid':          resource.uid,
      }
    end
  end
end
