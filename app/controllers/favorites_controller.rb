# frozen_string_literal: true

class FavoritesController < ApplicationController
  def index
    @favorite_tweets = current_user.favorite_tweets.order('favorites.created_at DESC').page(params[:page]).per(5)
  end
end
