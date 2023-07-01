# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    @comment_tweets = current_user.comment_tweets.order('comments.created_at DESC').page(params[:page]).per(5)
  end
end
