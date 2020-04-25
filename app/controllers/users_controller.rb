class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
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
    redirect_to fr_top_path
  end

  def my_reviews
  end

  def my_bookmarks
  end

  protected
  def user_params
    params.require(:user).permit(:name, :email, :password, :introduction, :profile_photo, :background_photo, :is_deleted)
  end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to fr_top_path
    end
  end
end