require 'rails_helper'

RSpec.describe Like, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Like.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Reviewモデルとの関係' do
      it 'N:1となっている' do
        expect(Like.reflect_on_association(:review).macro).to eq :belongs_to
      end
    end
  end
end
