# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :set_tweets, only: %i[index create]
  def index
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to root_path, notice: 'ツイートしました'
    else
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_tweets
    @tweets = Tweet.includes(:user).order(id: 'desc').page(params[:page]).per(5)
  end

  def tweet_params
    params.require(:tweet).permit(:text, :image)
  end
end
