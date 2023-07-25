# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment_tweet, only: %i[create]
  def index
    @comment_tweets = current_user.comment_tweets.order('comments.created_at DESC').page(params[:page]).per(5)
  end

  def create
    @comments = @tweet.comments.includes(:user).order(created_at: :desc).page(params[:page]).per(5)
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to tweet_path(@tweet)
      flash[:success] = 'コメントしました'
    else
      render 'tweets/show', status: :unprocessable_entity
    end
  end

  private

  def set_comment_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(tweet_id: params[:tweet_id])
  end
end
