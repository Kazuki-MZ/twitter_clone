# frozen_string_literal: true

class MytweetsController < ApplicationController
  def index
    @my_tweets = Tweet.where(user_id: current_user.id).order(id: 'desc').page(params[:page]).per(5)
  end
end
