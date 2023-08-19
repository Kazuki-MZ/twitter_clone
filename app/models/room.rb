# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :room_users, dependent: :destroy
  has_many :messages, dependent: :destroy
end
