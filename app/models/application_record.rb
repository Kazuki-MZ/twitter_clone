# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def favorite?(tweet)
    favorites.where(tweet_id: tweet.id).exists?
  end
end
