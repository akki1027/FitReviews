require 'rails_helper'

RSpec.describe HomesController, type: :controller do
  describe 'Topページ' do
    context '特定のページへ正しく遷移できるか' do
      it 'fr_topページへ正しく遷移できるか' do
        get :fr_top
        expect(response.status).to eq(200)
      end
      it 'topページへ正しく遷移できるか' do
        get :top
        expect(response.status).to eq(200)
      end
      it 'aboutページへ正しく遷移できるか' do
        get :about
        expect(response.status).to eq(200)
      end
    end
    context "Review投稿ページが正しく表示される" do
      before do
        get :fr_top
      end
      render_views
      it 'ヘッダーのリンクの文字が正しく表示されていること' do
        expect(response.body).to include('ランキング')
        expect(response.body).to include('レビューを書く')
        expect(response.body).to include('ログイン')
        expect(response.body).to include('サインアップ')
      end
      it 'セクションタイトルが正しく表示されていること' do
        expect(response.body).to include('ジャンルで探す')
        expect(response.body).to include('キーワードで探す')
        expect(response.body).to include('総合おすすめ商品')
        expect(response.body).to include('最近書かれたレビュー')
      end
      it 'フッターのリンクの文字が正しく表示されていること' do
        expect(response.body).to include('FitReviewsについて')
        expect(response.body).to include('開発者プロフィール')
        expect(response.body).to include('GitHub')
      end
    end
  end
end
