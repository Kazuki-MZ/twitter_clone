# frozen_string_literal: true

class FollowingUserTweetsController < ApplicationController
  def index
    @following_tweets = Tweet.where(user_id: [current_user.following_ids]).order(id: 'desc').page(params[:page]).per(5)
  end
end
