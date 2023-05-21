# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.string :telephone_number, null: false, default: ''
      t.date :date_of_birth, null: false
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.datetime :remember_created_at
      t.string   :unconfirmed_email
      t.timestamps null: false # Only if using reconfirmable
    end

    add_index :users, :email, unique: true
  end
end
