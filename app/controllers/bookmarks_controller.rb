# frozen_string_literal: true

class BookmarksController < ApplicationController
  def index
    @bookmark_tweets = current_user.bookmark_tweets.order('bookmarks.created_at DESC').page(params[:page]).per(5)
  end

  def create
    current_user.bookmarks.create!(tweet_id: params[:tweet_id])
    redirect_back(fallback_location: root_path)
    flash[:success] = 'ツイートをブックマークしました'
  end

  def destroy
    bookmark = current_user.bookmarks.find_by!(tweet_id: params[:tweet_id])
    bookmark.destroy!
    redirect_back(fallback_location: root_path)
    flash[:success] = 'ブックマークからツイートを削除しました'
  end
end
