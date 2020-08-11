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
      it '自己紹介文が表示される' do
        expect(page).to have_content(user.introduction)
      end
      it '編集リンクが表示される' do
        visit user_path(user)
        expect(page).to have_link '', href: edit_user_path(user)
      end
      it '最近書いたレビューと表示される' do
        expect(page).to have_content('最近書いたレビュー')
      end
      it 'ブックマークした商品と表示される' do
        expect(page).to have_content('ブックマークした商品')
      end
    end
    before do
      visit edit_user_path(user)
    end
    context 'ユーザー編集画面の表示テスト' do
      it 'プロフィール画像を追加すると表示される' do
        expect(page).to have_content('プロフィール画像を追加する')
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[profile_photo]'
      end
      it 'ユーザーネームと表示される' do
        expect(page).to have_content('ユーザーネーム')
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '自己紹介と表示される' do
        expect(page).to have_content('自己紹介')
      end
      it '自己紹介編集フォームに自分の自己紹介が表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      it 'メールアドレスと表示される' do
        expect(page).to have_content('メールアドレス')
      end
      it 'メールアドレス編集フォームに自分の自己紹介が表示される' do
        expect(page).to have_field 'user[email]', with: user.email
      end
      it '編集に成功する' do
        click_button '変更を保存する'
        expect(page).to have_content 'プロフィール情報を編集しました。'
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
      it '編集に失敗する' do
        fill_in 'user[name]', with: ''
        click_button '変更を保存する'
        expect(page).to have_content '入力してください'
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
    end
  end
end
