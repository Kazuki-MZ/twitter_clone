# frozen_string_literal: true

class Tweet < ApplicationRecord
  has_many_attached :images
  belongs_to :user
end
