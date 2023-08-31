# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'ログイン' do
    let(:confirmed_user) { create(:user) }
    let(:unconfirmed_user) { create(:user, confirmed_at: nil) }
    let(:new_user) { build(:user) }

    before do
      visit new_user_session_path
    end

    context 'パラメータが正常な場合' do
      it 'ログイン画面に遷移していること' do
        fill_in 'user_email', with: confirmed_user.email
        fill_in 'user_password', with: confirmed_user.password
        click_button 'ログイン'
        expect(page).to have_current_path(root_path)
        expect(page).to have_content 'ログインしました。'
      end
    end

    context 'メールアドレスが未入力な時' do
      it 'ログインが失敗すること' do
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: confirmed_user.password
        click_button 'ログイン'
        expect(page).to have_current_path(user_session_path)
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      end
    end

    context 'ユーザーがメール認証を完了してない場合' do
      it 'ログインが失敗すること' do
        fill_in 'user_email', with: unconfirmed_user.email
        fill_in 'user_password', with: unconfirmed_user.password
        click_button 'ログイン'
        expect(page).to have_current_path(user_session_path)
        expect(page).to have_content 'メールアドレスの本人確認が必要です。'
      end
    end

    context 'ユーザー登録されていない時' do
      it 'ログインが失敗すること' do
        fill_in 'user_email', with: new_user.email
        fill_in 'user_password', with: new_user.password
        click_button 'ログイン'
        expect(page).to have_current_path(user_session_path)
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      end
    end
  end
end
