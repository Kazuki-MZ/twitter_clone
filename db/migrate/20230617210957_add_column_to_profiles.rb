# frozen_string_literal: true

class AddColumnToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_reference :profiles, :user, foreign_key: true
  end
end
