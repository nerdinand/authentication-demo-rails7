Rails.application.routes.draw do
  root 'home#index'

  get 'home', to: 'home#index'

  resources :users, only: %i[new create]
  resources :user_sessions, only: %i[new create destroy]

  get 'log_in', to: redirect('/user_sessions/new')
  get 'sign_up', to: redirect('/users/new')
  delete 'log_out', to: 'user_sessions#destroy'
end
