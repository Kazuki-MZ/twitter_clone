# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  inverse_of: :follower,
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   inverse_of: :followed,
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_one :profile, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_tweets, through: :favorites, source: :tweet
  has_many :retweets, dependent: :destroy
  has_many :retweet_tweets, through: :retweets, source: :tweet
  has_many :comments, dependent: :destroy
  has_many :comment_tweets, through: :comments, source: :tweet
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable, :omniauthable, omniauth_providers: %i[github]

  validates :name, presence: true
  validates :telephone_number, presence: true, if: -> { provider.blank? }
  validates :date_of_birth, presence: true, if: -> { provider.blank? }
  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? & provider.present? }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name || auth.info.nickname
    end
  end
end
