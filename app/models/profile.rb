# frozen_string_literal: true

class Profile < ApplicationRecord
  has_one_attached :header
  has_one_attached :icon
  belongs_to :user
end
