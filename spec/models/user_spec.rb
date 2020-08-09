require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '正しく保存されるかのテスト' do
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

  describe 'バリデーションのテスト' do
    let(:user) { build(:user) }
    subject { test_user.valid? }
    context 'nameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false;
      end
      it '2文字以上であること' do
        test_user.name = Faker::Lorem.characters(number:1)
        is_expected.to eq false;
      end
      it '20文字以下であること' do
        test_user.name = Faker::Lorem.characters(number:21)
        is_expected.to eq false;
      end
    end
    context 'emailカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.email = ''
        is_expected.to eq false;
      end
    end
    context 'introductionカラム' do
      let(:test_user) { user }
      it '150文字以内である事' do
        test_user.introduction = Faker::Lorem.characters(number:151)
        is_expected.to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Reviewモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end
    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:likes).macro).to eq :has_many
      end
    end
    context 'Bookmarkモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end
  end
end
