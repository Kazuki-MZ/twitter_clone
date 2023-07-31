# frozen_string_literal: true

class RetweetsController < ApplicationController
  def index
    @retweet_tweets = current_user.retweet_tweets.order('retweets.created_at DESC').page(params[:page]).per(5)
  end

  def create
    current_user.retweets.create!(tweet_id: params[:tweet_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    retweet = current_user.retweets.find_by!(tweet_id: params[:tweet_id])
    retweet.destroy!
    redirect_back(fallback_location: root_path)
  end
end
