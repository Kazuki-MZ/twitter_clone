# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @tweets = Tweet.includes(:user).order(id: 'desc').page(params[:page]).per(5)
    @following_tweets = Tweet.where(user_id: [current_user.following_ids]).order(id: 'desc').page(params[:page]).per(5)
  end
end
