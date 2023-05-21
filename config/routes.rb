# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  resources :tweets, only: :index
  root to: 'tweets#index'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
