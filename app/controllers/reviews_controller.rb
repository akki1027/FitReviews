class ReviewsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def index
  end

  def create
    @items = RakutenWebService::Ichiba::Item.search(itemCode: params[:item_code])
    # アイテムの保存
    # transactionを使うことで、itemが保存され、尚且つreviewも保存されないと処理が完了しない
    result = ActiveRecord::Base.transaction do
      item = Item.find_or_create_by(item_params)
      current_user.reviews.create(review_params(item))
      true
    end
    if result
      flash[:notice] = "レビューを作成しました。"
      redirect_to reviews_new_path(@items.first["itemCode"])
    else
      render 'new'
    end
  end

  def new
    @item = RakutenWebService::Ichiba::Item.search(itemCode: params[:itemCode])
    @review = Review.new
    # rakuten_item_idが楽天のitemCodeと一致するものを取得
    @saved_item = Item.find_by(rakuten_item_id: @item.first["itemCode"])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def show
  end

  def update
    review = Review.find(params[:id])
    item = Item.find_by(id: review.item_id)
    review.update(review_update_params)
    redirect_to reviews_new_path(item.rakuten_item_id)
  end

  def destroy
    review = Review.find(params[:id])
    item = Item.find_by(id: review.item_id)
    review.destroy
    # newページのURLには、楽天の商品Codeを含みたいので、rakuten_item_idに返す
    redirect_to reviews_new_path(item.rakuten_item_id)
  end

  def search
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end

  private
  def review_params(item)
    params.require(:review).permit(:body, :item_image, :rate).merge({item_id: item.id})
    # { body: '', item_image: 'utl/ho/huga/item.img, rate: 5 }
  end

  def review_update_params
    params.require(:review).permit(:body, :item_image, :rate)
  end

  def item_params
    { name: @items.first['itemName'], rakuten_item_id: @items.first['itemCode'] }
  end

  def correct_user
    review = Review.find(params[:id])
    if current_user != review.user
      redirect_to fr_top_path
    end
  end
end
