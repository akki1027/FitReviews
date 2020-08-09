require 'rails_helper'

RSpec.describe Review, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:review) { build(:review, user_id: user.id) }
    context 'bodyカラム' do
      it '空欄でないこと' do
        review.body = ''
        expect(review.valid?).to eq false;
      end
      it '300文字以下であること' do
        review.body = Faker::Lorem.characters(number:301)
        expect(review.valid?).to eq false;
      end
    end
    context 'rateカラム' do
      it '空欄でないこと' do
        review.rate = ''
        expect(review.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Review.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Itemモデルとの関係' do
      it 'N:1となっている' do
        expect(Review.reflect_on_association(:item).macro).to eq :belongs_to
      end
    end
    context 'Likeモデルとの関係' do
      it 'N:1となっている' do
        expect(Review.reflect_on_association(:likes).macro).to eq :has_many
      end
    end
  end
end
