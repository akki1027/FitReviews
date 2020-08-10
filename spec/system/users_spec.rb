require 'rails_helper'
# pending "add some examples to (or delete) #{__FILE__}"
describe '新規登録のテスト' do
  context '新規登録画面に遷移' do
    before do
      visit new_user_registration_path
    end
    # render_views
    it '新規登録に成功する'do
      fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
      fill_in 'user[email]', with: Faker::Internet.email
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_on '新規登録'

      expect(page).to have_content 'アカウント登録が完了しました'
    end
  end
end
