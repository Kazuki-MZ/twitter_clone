# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'ログイン' do
    let(:confirmed_user) { create(:user) }
    let(:unconfirmed_user) { create(:user, confirmed_at: nil) }
    let(:unexist_user) { build(:user) }

    context 'ユーザーがメール認証を完了している場合' do
      it 'ホームページに遷移すること' do
        post user_session_path, params: { user: { email: confirmed_user.email, password: confirmed_user.password } }
        expect(response).to redirect_to root_path
      end
    end

    context 'ユーザーがメール認証を完了してない場合' do
      it 'ログイン画面にリダイレクトすること' do
        post user_session_path, params: { user: { email: unconfirmed_user.email, password: unconfirmed_user.password } }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーが登録されていない場合' do
      it 'エラーメッセージが表示されていること' do
        post user_session_path, params: { user: { email: unexist_user.email, password: unexist_user.password } }
        expect(response.body).to include 'メールアドレスまたはパスワードが違います。'
      end
    end
  end
end
