Rails.application.routes.draw do
  # api token auth
  mount_devise_token_auth_for 'User', at: 'auth'

  # api docs
  apipie

  # api resources
  resources :task_lists do
    resources :tasks
  end
end
