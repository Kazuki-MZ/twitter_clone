# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def favorite?(tweet)
    favorites.where(tweet_id: tweet.id).exists?
  end

  def retweet?(tweet)
    retweets.where(tweet_id: tweet.id).exists?
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
