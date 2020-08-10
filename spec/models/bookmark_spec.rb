require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Bookmark.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Itemモデルとの関係' do
      it 'N:1となっている' do
        expect(Bookmark.reflect_on_association(:item).macro).to eq :belongs_to
      end
    end
  end
end
