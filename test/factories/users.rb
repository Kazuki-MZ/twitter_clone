# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'john' }
    email { 'jone@example.com' }
    password { 'D3keL1fS' }
    password_confirmation { 'D3keL1fS' }
    telephone_number { '0801234567' }
    date_of_birth { Date.new(2000, 1, 1) }
    confirmed_at { Time.zone.today }

    after(:create) do |user|
      create(:profile, user:, nickname: user.name)
    end
  end
end
