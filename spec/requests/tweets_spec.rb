# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  describe 'ツイート作成' do
    let(:user) { create(:user) }
    let(:tweet_params) { attributes_for(:tweet) }
    let(:invalid_tweet_params) { attributes_for(:tweet, text: '') }

    before do
      sign_in user
    end

    context 'パラメータが正常な場合' do
      it 'createが成功していること' do
        expect do
          post tweets_path, params: { tweet: tweet_params }
        end.to change(user.tweets, :count).by(1)
      end

      it 'ツイート作成後ホームページへリダイレクトすること' do
        post tweets_path, params: { tweet: tweet_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'パラメータが不正な場合' do
      it 'エラーメッセージが表示されていること' do
        post tweets_path, params: { tweet: invalid_tweet_params }
        expect(response.body).to include 'を入力してください'
      end

      it 'createが失敗していること' do
        expect do
          post tweets_path, params: { tweet: invalid_tweet_params }
        end.not_to change(user.tweets, :count)
      end
    end
  end
end
