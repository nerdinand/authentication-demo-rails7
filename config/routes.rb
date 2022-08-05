# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  get 'home', to: 'home#index'

  resources :users, only: %i[new create]
  namespace :user do
    resources :email_confirmations, only: %i[new create]
    namespace :email_confirmations do
      post :resend
    end
    resources :password_reset_requests, only: %i[new create]
    resources :password_resets, only: %i[new create]
  end

  resources :user_sessions, only: %i[new create destroy]

  get 'log_in', to: redirect('/user_sessions/new')
  get 'sign_up', to: redirect('/users/new')
  delete 'log_out', to: 'user_sessions#destroy'
end
