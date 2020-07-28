class ReviewsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def create
    @item = RakutenWebService::Ichiba::Item.search(itemCode: params[:item_code])
    ActiveRecord::Base.transaction do
      @saved_item = Item.find_by(item_params)
      @review = current_user.reviews.new(review_params(@saved_item))
      @review.save
      if not @review.save
        @reviews = Review.where(item_id: @saved_item.id).page(params[:page]).reverse_order
        @average_rate = Review.where(item_id: @saved_item.id).average(:rate)
        render :new
      end
    end
  end

  def new
    @item = RakutenWebService::Ichiba::Item.search(itemCode: params[:itemCode])
    @review = Review.new
    # rakuten_item_idが楽天のitemCodeと一致するものを取得
    @saved_item = Item.find_by(rakuten_item_id: @item.first["itemCode"])
    @reviews = Review.where(item_id: @saved_item.id).page(params[:page]).reverse_order
    @average_rate = Review.where(item_id: @saved_item.id).average(:rate)
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    item = Item.find_by(id: @review.item_id)
    @referrer = params[:referrer]
    if @review.update(review_update_params)
      # redirect to the page previously visited
      redirect_to @referrer
    end
  end

  def destroy
    @review = Review.find(params[:id])
    item = Item.find_by(id: @review.item_id)
    @review.destroy
  end

  def search
    if params[:page]
      @page = params[:page].to_i
    else
      @page = 1
    end
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword], genreId: params[:genreId]).page(params[:page])
      @keyword = params[:keyword]
      @genre_id = params[:genreId]
      @has_next_page = @items.has_next_page?
    else
      @items = RakutenWebService::Ichiba::Item.search(keyword: "プロテイン", genreId: 567603).page(params[:page])
      @keyword = "プロテイン"
      @genre_id = 567603
      @has_next_page = @items.has_next_page?
    end
  end

  def save_item
    # new画面に移動する時にその楽天商品をデータベースに保存する
    @items = RakutenWebService::Ichiba::Item.search(itemCode: params[:itemCode])
    genre_id = @items.first['genreId']
    genre_ids = [567603, 566807, 563727, 201865]
    index = genre_ids.index(genre_id)
    # ４つのジャンルIDに必ず紐付けたい。現状、子供のジャンルIDのデータも検索できてしまうため、商品に紐づくジャンルIDが４つのジャンルに属さない可能性がある。
    # そのため、最も近しい親ジャンルを商品に紐付ける。なので、楽天の持つ商品とジャンルの紐付きと必ずしも一致しない仕様。
    if index.nil?
      parent_genres = RakutenWebService::Ichiba::Genre[genre_id].parents
      parent_genres.reverse_each do |parent|
        parent_index = genre_ids.index(parent.params["genreId"])
        if parent_index.present?
          genre_id = genre_ids[parent_index]
          break
        end
      end
    end
    Item.find_or_create_by({ name: @items.first['itemName'], rakuten_item_id: @items.first['itemCode'], rakuten_genre_id: genre_id })
    redirect_to reviews_new_path(@items.first["itemCode"])
  end

  private
  def review_params(item)
    params.require(:review).permit(:body, :item_image, :rate).merge({item_id: @saved_item.id})
    # { body: '', item_image: 'utl/ho/huga/item.img, rate: 5 }
  end

  def review_update_params
    params.require(:review).permit(:body, :item_image, :rate)
  end

  def item_params
    { rakuten_item_id: @item.first['itemCode'] }
    # { name: @items.first['itemName'], rakuten_item_id: @items.first['itemCode'] }
  end

  def correct_user
    review = Review.find(params[:id])
    if current_user != review.user
      redirect_to root_path
    end
  end
end
