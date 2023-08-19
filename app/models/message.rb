# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :text, presence: true, length: { maximum: 140 }
end
