# frozen_string_literal: true

class Tweet < ApplicationRecord
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favarites, source: :user
  has_many :retweets, dependent: :destroy
  has_many :retweet_users, through: :retweets, source: :user
  has_many :comments, dependent: :destroy
  has_many :comments_users, through: :comments, source: :user
  belongs_to :user

  validates :text, presence: true, length: { maximum: 140 }, if: -> { image.blank? }
end
