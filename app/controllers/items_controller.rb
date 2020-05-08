class ItemsController < ApplicationController
  def search
  	if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end

  def select_genre
  end

  def ranking
  	@rankings = Review.group(:item_id).limit(5).select("reviews_item_id, average_rate").order('average_rate desc').average(:rate)
  end
end
