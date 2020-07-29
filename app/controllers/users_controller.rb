class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @bookmarks = Bookmark.where(user_id: current_user.id).limit(4).reverse_order
    @bookmarked_items = []
    @bookmarks.each do |bookmark|
      @bookmarked_items << RakutenWebService::Ichiba::Item.search(itemCode: bookmark.item.rakuten_item_id)
    end
    @reviews = Review.where(user_id: current_user.id).limit(4).reverse_order
    @items = []
    @reviews.each do |review|
      @items << RakutenWebService::Ichiba::Item.search(itemCode: review.item.rakuten_item_id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィール情報を編集しました。"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def leave
    @user = User.find(params[:id])
  end

  def hide
    @user = User.find(params[:id])
    #is_deletedカラムにフラグを立てる(defaultはfalse)
    @user.update(is_deleted: true)
    #ログアウトさせる
    reset_session
    flash[:notice] = "FitReviewsをご利用いただきまして誠にありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  def my_reviews
    @user = User.find(params[:id])
    @reviews = Review.where(user_id: current_user.id).page(params[:page]).per(8).reverse_order
    @items = []
    @reviews.each do |review|
      @items << RakutenWebService::Ichiba::Item.search(itemCode: review.item.rakuten_item_id)
    end
  end

  def my_bookmarks
    @user = User.find(params[:id])
    @bookmarks = Bookmark.where(user_id: current_user.id).page(params[:page]).per(8).reverse_order
    @bookmarked_items = []
    @bookmarks.each do |bookmark|
      @bookmarked_items << RakutenWebService::Ichiba::Item.search(itemCode: bookmark.item.rakuten_item_id)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :introduction, :profile_photo, :background_photo, :is_deleted)
  end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to root_path
    end
  end
end
