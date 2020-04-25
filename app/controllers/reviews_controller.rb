class ReviewsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def index
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  def search
  end

  protected
  def review_params
    params.require(:review).permit(:body, :item_image, :rate)
  end

  def correct_user
    review = Review.find(params[:id])
    if current_user != review.user
      redirect_to fr_top_path
    end
  end
end
