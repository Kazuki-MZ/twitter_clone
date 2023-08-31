# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'サインアップ' do
    let(:new_user) { build(:user) }
    let(:exist_user) { create(:user) }

    before do
      visit new_user_registration_path
    end

    context 'パラメータが正常な場合' do
      it 'ログイン画面に遷移していること' do
        fill_in 'user_name', with: new_user.name
        fill_in 'user_email', with: new_user.email
        fill_in 'user_telephone_number', with: new_user.telephone_number
        fill_in 'user_date_of_birth', with: new_user.date_of_birth
        fill_in 'user_password', with: new_user.password
        fill_in 'user_password_confirmation', with: new_user.password_confirmation
        click_button '新規登録'
        expect(page).to have_current_path(user_session_path)
        expect(page).to have_content 'メールを送信しました。リンクをクリックし、ログインしてください。'
      end
    end

    context '名前が未入力の時' do
      it 'ユーザーの新規作成が失敗すること' do
        fill_in 'user_name', with: ''
        fill_in 'user_email', with: new_user.email
        fill_in 'user_telephone_number', with: new_user.telephone_number
        fill_in 'user_date_of_birth', with: new_user.date_of_birth
        fill_in 'user_password', with: new_user.password
        fill_in 'user_password_confirmation', with: new_user.password_confirmation
        click_button '新規登録'
        expect(page).to have_current_path(user_registration_path)
        expect(page).to have_content '名前を入力してください'
      end
    end

    context '登録済みemailが存在している時' do
      it 'ユーザーの新規作成が失敗すること' do
        fill_in 'user_name', with: new_user.name
        fill_in 'user_email', with: exist_user.email
        fill_in 'user_telephone_number', with: new_user.telephone_number
        fill_in 'user_date_of_birth', with: new_user.date_of_birth
        fill_in 'user_password', with: new_user.password
        fill_in 'user_password_confirmation', with: new_user.password_confirmation
        click_button '新規登録'
        expect(page).to have_current_path(user_registration_path)
        expect(page).to have_content 'メールアドレスはすでに存在します'
      end
    end
  end
end
