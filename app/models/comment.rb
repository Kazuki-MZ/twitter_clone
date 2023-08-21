# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  validates :content, presence: true, length: { maximum: 140 }
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
