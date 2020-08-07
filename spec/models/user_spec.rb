require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context 'Userのデータが正しく保存される' do
    before do
      @user = User.new(email: 'rspec@test', password: "123456", name: '山田', introduction: 'こんにちは、初めまして。')
      @user.save
    end
    it '全て入力されているので保存する' do
      expect(@user).to be_valid
    end
  end

  context 'Userのデータが正しく保存されない' do
    before do
      @user = User.new(email: '', password: "123456", name: '山田', introduction: 'こんにちは、初めまして。')
      @user.save
    end
    it 'emailが入力されてないので保存されない。' do
      expect(@user).to be_invalid
      expect(@user.errors[:email]).to include('を入力してください')
    end
  end
end
