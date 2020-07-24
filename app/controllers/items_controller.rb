class ItemsController < ApplicationController
  def search
  	if params[:page]
      @page = params[:page].to_i
    else
      @page = 1
    end
    if params[:keyword] && params[:genreId]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword], genreId: params[:genreId]).page(params[:page])
      @keyword = params[:keyword]
      @genre_id = params[:genreId]
      @has_next_page = @items.has_next_page?
    elsif params[:genreId]
      @items = RakutenWebService::Ichiba::Item.search(genreId: params[:genreId]).page(params[:page])
      @genre_id = params[:genreId]
      @has_next_page = @items.has_next_page?
    end
  end

  def ranking
    if params[:genreId]
      @rankings = Review.joins(:item).where("items.rakuten_genre_id = ?", params[:genreId]).group(:item_id).select("reviews_item_id, average_rate").order('average_rate desc').average(:rate)
      @num = 1
      @genre = params[:genreId]
    else
      @rankings = Review.joins(:item).where("items.rakuten_genre_id = ?", 567603).group(:item_id).select("reviews_item_id, average_rate").order('average_rate desc').average(:rate)
      @num = 1
      @genre = "567603"
    end
    # @rankings = Review.group(:item_id).limit(5).select("reviews_item_id, average_rate").order('average_rate desc').average(:rate)
  end
end
