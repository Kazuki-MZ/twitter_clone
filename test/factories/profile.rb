# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    nickname { 'ニックネーム' }
    after(:create) do |profile|
      profile.icon.attach(io: File.open(Rails.root.join('app/assets/images/icon.jpg')), filename: 'icon.jpeg')
      profile.header.attach(io: File.open(Rails.root.join('app/assets/images/header.jpg')), filename: 'header.jpeg')
    end
  end
end
