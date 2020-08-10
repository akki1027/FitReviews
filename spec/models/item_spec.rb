require 'rails_helper'

RSpec.describe Item, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'アソシエーションのテスト' do
    context 'Reviewモデルとの関係' do
      it 'N:1となっている' do
        expect(Item.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end
    context 'Bookmarkモデルとの関係' do
      it 'N:1となっている' do
        expect(Item.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end
  end
end
