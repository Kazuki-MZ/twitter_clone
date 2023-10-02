# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
jone = User.new({
                  name: 'test_jone',
                  email: 'jone@test.com',
                  password: '********',
                  telephone_number: 111_111,
                  date_of_birth: Date.new(2000, 1, 1)
                })
jone.skip_confirmation!
jone.save!

jone.create_profile!({ nickname: 'Jone', bio: "Hello I'm jone", location: '東京都', website: 'https://www.jone.example.com' })

jone.profile.icon.attach(io: File.open(Rails.root.join('app/assets/images/fish.jpg')),
                         filename: 'fish.jpeg')
jone.profile.header.attach(io: File.open(Rails.root.join('app/assets/images/set_header.jpg')),
                           filename: 'set_header.jpeg')

nick = User.new({
                  name: 'test_nick',
                  email: 'nick@test.com',
                  password: '********',
                  telephone_number: 111_111,
                  date_of_birth: Date.new(2000, 1, 1)
                })
nick.skip_confirmation!
nick.save!

nick.create_profile!({ nickname: 'Nick', bio: "Hello I'm nick", location: '東京都', website: 'https://www.nick.example.com' })
nick.profile.icon.attach(io: File.open(Rails.root.join('app/assets/images/cat.jpg')),
                         filename: 'cat.jpeg')
nick.profile.header.attach(io: File.open(Rails.root.join('app/assets/images/set_header.jpg')),
                           filename: 'set_header.jpeg')

maria = User.new({
                   name: 'test_maria',
                   email: 'maria@test.com',
                   password: '********',
                   telephone_number: 111_111,
                   date_of_birth: Date.new(2000, 1, 1)
                 })
maria.skip_confirmation!
maria.save!

maria.create_profile!({ nickname: 'Maria', bio: "Hello I'm maria", location: '東京都', website: 'https://www.maria.example.com' })
maria.profile.icon.attach(io: File.open(Rails.root.join('app/assets/images/panpukin.jpg')),
                          filename: 'panpukin.jpeg')
maria.profile.header.attach(io: File.open(Rails.root.join('app/assets/images/set_header.jpg')),
                            filename: 'set_header.jpeg')

jone_tweet1 = jone.tweets.create!(text: 'Test tweet from John')
jone_tweet2 = jone.tweets.create!(text: 'Hello from John')
nick_tweet1 = nick.tweets.create!(text: 'Test tweet from Nick')
maria_tweet1 = maria.tweets.create!(text: 'Test tweet from Maria')

jone.favorites.create!(tweet_id: nick_tweet1.id)
jone.comments.create!(content: 'Nice', tweet_id: maria_tweet1.id)
nick.retweets.create!(tweet_id: jone_tweet1.id)
maria.favorites.create!(tweet_id: jone_tweet2.id)

jone.following << nick
nick.following << maria
maria.following << jone
