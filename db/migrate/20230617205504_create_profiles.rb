# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :user_name
      t.string :bio
      t.string :location
      t.string :website
      t.timestamps
    end
  end
end
