Rails.application.routes.draw do
  # api token auth
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    passwords: 'overrides/passwords',
  }

  # api docs
  apipie

  post '/send_reset_password_instructions', to: 'reset_password#send_reset_password_instructions'
  get  '/reset_password',                   to: 'reset_password#reset_password', as: :reset_password

  # disposable token / (QR code) auth
  resources :disposable_tokens, only: %i(create) do
    collection do
      post '/sign_in_with', action: :sign_in_with
    end
  end

  # api resources
  resource :me, only: %i(show update) do
    post '/register_device', action: :register_device
  end

  resources :task_lists do
    post '/change_position', action: :change_position

    resources :task_list_users, only: %i(index create) do
      collection do
        delete '/', action: :destroy
      end
    end

    resources :tasks do
      post '/complete',        action: :complete
      post '/uncomplete',      action: :uncomplete
      post '/change_position', action: :change_position
      post '/move',            action: :move
    end
  end

  resources :notification_requests, only: %i() do
    collection do
      post '/tasks', action: :tasks
    end
  end
end
