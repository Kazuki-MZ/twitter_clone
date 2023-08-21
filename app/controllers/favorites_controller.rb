# frozen_string_literal: true

class FavoritesController < ApplicationController
  def index
    @favorite_tweets = current_user.favorite_tweets.order('favorites.created_at DESC').page(params[:page]).per(5)
  end

  def create
    @favorite = current_user.favorites.create!(tweet_id: params[:tweet_id])
    EventNoticeMailer.with(event: @favorite, user: @favorite.tweet.user).notification_mail.deliver_later if @favorite.tweet.user != current_user
    redirect_back(fallback_location: root_path)
  end

  def destroy
    favorite = current_user.favorites.find_by!(tweet_id: params[:tweet_id])
    favorite.destroy!
    redirect_back(fallback_location: root_path)
  end
end
