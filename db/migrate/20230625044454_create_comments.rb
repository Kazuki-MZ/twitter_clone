# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :comment_content
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true
      t.timestamps

      t.index %i[user_id tweet_id], unique: true
    end
  end
end
