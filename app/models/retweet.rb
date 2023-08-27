# frozen_string_literal: true

class Retweet < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  validates :user_id, uniqueness: { scope: :tweet_id }
  has_one :notification, as: :event, dependent: :destroy

  after_create_commit :create_notification

  private

  def create_notification
    return if user_id == tweet.user_id

    Notification.create!(
      event: self,
      user: tweet.user
    )
  end
end
