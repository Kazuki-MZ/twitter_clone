# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user) { build(:user) }

    it '全ての項目の入力が存在すれば登録できること' do
      expect(user).to be_valid
    end

    it 'nameがない場合は登録できないこと' do
      user.name = nil
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end

    it 'emailがない場合は登録できないこと' do
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'passwordがない場合は登録できないこと' do
      user.password = nil
      user.valid?
      expect(user.errors[:password]).to include('を入力してください')
    end

    it 'telephone_numberがない場合は登録できないこと' do
      user.telephone_number = nil
      user.valid?
      expect(user.errors[:telephone_number]).to include('を入力してください')
    end

    it 'date_of_birthがない場合は登録できないこと' do
      user.date_of_birth = nil
      user.valid?
      expect(user.errors[:date_of_birth]).to include('を入力してください')
    end

    it '適切なemailだけを許可する' do
      user.email = '@1234ww@567'
      user.valid?
      expect(user.errors[:email]).to include('は不正な値です')
    end
  end
end
