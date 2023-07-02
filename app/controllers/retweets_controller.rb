# frozen_string_literal: true

class RetweetsController < ApplicationController
  def index
    @retweet_tweets = current_user.retweet_tweets.order('retweets.created_at DESC').page(params[:page]).per(5)
  end
end
