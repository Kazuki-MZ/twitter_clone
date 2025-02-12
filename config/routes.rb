# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  resources :tweets, only: %i[index create show] do
    resources :comments, only: %i[create]
    resource :favorites, only: %i[create destroy]
    resource :retweets, only: %i[create destroy]
    resource :bookmarks, only: %i[create destroy]
  end
  root to: 'tweets#index'

  resources :bookmarks, only: %i[index]
  resource :relationships, only: %i[create destroy]
  resources :following_user_tweets, only: %i[index]
  resource :profile, only: %i[edit update]
  resource :profile, only: %i[show] do
    resources :favorites, only: %i[index]
    resources :retweets, only: %i[index]
    resources :comments, only: %i[index]
  end

  resources :rooms, only: %i[index show create] do
    resources :messages, only: %i[index create]
  end
  resources :notifications, only: %i[index]
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
