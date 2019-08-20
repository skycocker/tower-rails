Rails.application.routes.draw do
  # api token auth
  mount_devise_token_auth_for 'User', at: 'auth'

  # api docs
  apipie

  # api resources
  resources :task_lists do
    resources :tasks do
      post '/complete',        action: :complete
      post '/uncomplete',      action: :uncomplete
      post '/change_position', action: :change_position
    end
  end
end
