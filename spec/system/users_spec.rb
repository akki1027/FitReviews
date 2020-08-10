require 'rails_helper'
# pending "add some examples to (or delete) #{__FILE__}"
describe '新規登録のテスト' do
  context '新規登録画面に遷移' do
    before do
      visit new_user_registration_path
    end
    it '新規登録に成功する'do
      fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
      fill_in 'user[email]', with: Faker::Internet.email
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_on '新規登録'

      expect(page).to have_content 'アカウント登録が完了しました'
    end
  end
  describe 'ユーザーのテスト' do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end
    context 'マイページのテスト' do
      before do
        visit user_path(user)
      end
      it '名前が表示される' do
        expect(page).to have_content(user.name)
      end
      it '編集リンクが表示される' do
        visit user_path(user)
        expect(page).to have_link '', href: edit_user_path(user)
      end
    end
  end
end
