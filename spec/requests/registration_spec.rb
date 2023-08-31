# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'サインアップ' do
    let(:user_params) { attributes_for(:user) }
    let(:invalid_user_params) { attributes_for(:user, name: '') }
    let(:exist_user) { create(:user) }

    context 'パラメーターが正常な場合' do
      it '303レスポンスを返すこと' do
        post user_registration_path, params: { user: user_params }
        expect(response).to have_http_status '303'
      end

      it 'createが成功していること' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by(1)
      end
    end

    context 'パラメータが不正な場合' do
      it 'createが失敗していること' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.not_to change(User, :count)
      end

      it 'エラーメッセージが表示されていること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include 'を入力してください'
      end
    end

    context '登録済みemailが存在している場合' do
      it 'エラーメッセージが表示されていること' do
        post user_registration_path, params: { user: { name: exist_user.name, email: exist_user.email, telephone_number: exist_user.telephone_number,
                                                       date_of_birth: exist_user.date_of_birth, password: exist_user.password, password_confirmation: exist_user.password_confirmation } }
        expect(response.body).to include 'メールアドレスはすでに存在します'
      end
    end
  end
end
