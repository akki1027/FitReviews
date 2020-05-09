class ItemsController < ApplicationController
  def search
  	if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end

  def ranking
    if params[:genreId]
      @rankings = Review.joins(:item).where("items.rakuten_genre_id = ?", params[:genreId]).group(:item_id).limit(5).select("reviews_item_id, average_rate").order('average_rate desc').average(:rate)
    else
      @rankings = Review.joins(:item).where("items.rakuten_genre_id = ?", 567603).group(:item_id).limit(5).select("reviews_item_id, average_rate").order('average_rate desc').average(:rate)
    end
    # @rankings = Review.group(:item_id).limit(5).select("reviews_item_id, average_rate").order('average_rate desc').average(:rate)
  end
end
