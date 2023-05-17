# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :tweets, only: :index
  root to: 'tweets#index'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
