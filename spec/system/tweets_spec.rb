# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :system do
  describe 'ツイート作成' do
    let(:user) { create(:user) }

    before do
      sign_in user
      visit root_path
    end

    context 'パラメータが正常場合' do
      it '作成したツイートが表示されていること' do
        fill_in 'tweet_text', with: 'Hello'
        click_button 'ツイートする'
        expect(page).to have_content 'Hello'
      end

      it 'ツイート一覧画面に遷移していること' do
        fill_in 'tweet_text', with: 'Hello'
        click_button 'ツイートする'
        expect(page).to have_current_path(root_path)
      end
    end

    context 'パラメータが不正な時' do
      it 'エラーメッセージが表示されていること' do
        click_button 'ツイートする'
        expect(page).to have_content 'テキストを入力してください'
      end

      it '422 Unprocessable Entityが返されること' do
        click_button 'ツイートする'
        expect(page).to have_http_status(:unprocessable_entity)
      end

      it '140文字以上の時エラーメッセージが表示されていること' do
        fill_in 'tweet_text', with: 'a' * 141
        click_button 'ツイートする'
        expect(page).to have_content 'テキストは140文字以内で入力してください'
      end
    end
  end
end
