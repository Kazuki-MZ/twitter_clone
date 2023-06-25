# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @my_tweets = Tweet.where(user_id: current_user.id).includes(:user).order(id: 'desc').page(params[:page]).per(5)
    @favorite_tweets = current_user.favorite_tweets.order(id: 'desc').page(params[:page]).per(5)
    @retweet_tweets = current_user.retweet_tweets.order(id: 'desc').page(params[:page]).per(5)
    @comment_tweets = current_user.comment_tweets.order(id: 'desc').page(params[:page]).per(5)
  end
end
