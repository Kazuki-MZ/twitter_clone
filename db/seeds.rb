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

jone.create_profile!({ user_name: 'Jone', bio: "Hello I'm jone", location: '東京都', website: 'https://www.jone.example.com' })

jone.profile.icon.attach(io: File.open(Rails.root.join('app/assets/images/dog.jpg')),
                         filename: 'dog.jpeg')
jone.profile.header.attach(io: File.open(Rails.root.join('app/assets/images/header.jpg')),
                           filename: 'header.jpeg')

nick = User.new({
                  name: 'test_nick',
                  email: 'nick@test.com',
                  password: '********',
                  telephone_number: 111_111,
                  date_of_birth: Date.new(2000, 1, 1)
                })
nick.skip_confirmation!
nick.save!

nick.create_profile!({ user_name: 'Nick', bio: "Hello I'm nick", location: '東京都', website: 'https://www.nick.example.com' })
nick.profile.icon.attach(io: File.open(Rails.root.join('app/assets/images/shark.jpg')),
                         filename: 'shark.jpeg')
nick.profile.header.attach(io: File.open(Rails.root.join('app/assets/images/header.jpg')),
                           filename: 'header.jpeg')

maria = User.new({
                   name: 'test_maria',
                   email: 'maria@test.com',
                   password: '********',
                   telephone_number: 111_111,
                   date_of_birth: Date.new(2000, 1, 1)
                 })
maria.skip_confirmation!
maria.save!

maria.create_profile!({ user_name: 'Maria', bio: "Hello I'm maria", location: '東京都', website: 'https://www.maria.example.com' })
maria.profile.icon.attach(io: File.open(Rails.root.join('app/assets/images/banana.jpg')),
                          filename: 'banana.jpeg')
maria.profile.header.attach(io: File.open(Rails.root.join('app/assets/images/header.jpg')),
                            filename: 'header.jpeg')

jone_tweet1 = jone.tweets.create!(text: 'Test tweet from John')
jone_tweet2 = jone.tweets.create!(text: 'Hello from John')
jone_tweet3 = jone.tweets.create!(text: 'Nice!')
nick_tweet1 = nick.tweets.create!(text: 'Test tweet from Nick')
nick_tweet2 = nick.tweets.create!(text: 'Hello')
nick_tweet3 = nick.tweets.create!(text: 'Nice!!!')
maria_tweet1 = maria.tweets.create!(text: 'Test tweet from Maria')
maria_tweet2 = maria.tweets.create!(text: 'Hello from Maria')
maria_tweet3 = maria.tweets.create!(text: 'Oh!!')

jone.following << nick
nick.following << maria
maria.following << jone

jone.favorite_tweets << [maria_tweet2, nick_tweet1, nick_tweet2, nick_tweet3, maria_tweet1, maria_tweet3]
nick.favorite_tweets << [jone_tweet1, jone_tweet2, jone_tweet3, maria_tweet1, maria_tweet2, maria_tweet3]
maria.favorite_tweets << [jone_tweet1, jone_tweet2, jone_tweet3, nick_tweet1, nick_tweet2, nick_tweet3]

jone.retweet_tweets << [maria_tweet1, maria_tweet2, nick_tweet1, nick_tweet2, nick_tweet3, maria_tweet3]
nick.retweet_tweets << [jone_tweet1, jone_tweet2, jone_tweet3, maria_tweet1, maria_tweet2, maria_tweet3]
maria.retweet_tweets << [nick_tweet2, nick_tweet3, jone_tweet1, jone_tweet2, jone_tweet3, nick_tweet1]

jone.comment_tweets << [maria_tweet3, nick_tweet1, nick_tweet2, nick_tweet3, maria_tweet1, maria_tweet2]
nick.comment_tweets << [jone_tweet1, jone_tweet2, jone_tweet3, maria_tweet1, maria_tweet2, maria_tweet3]
maria.comment_tweets << [jone_tweet1, jone_tweet2, jone_tweet3, nick_tweet1, nick_tweet2, nick_tweet3]
