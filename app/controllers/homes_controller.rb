class HomesController < ApplicationController
  def top
  end

  def fr_top
  	@rankings = Review.group(:item_id).limit(3).select("reviews_item_id, average_rate").order('average_rate desc').average(:rate)
  	# @reviews = Review.all.page(params[:page]).reverse_order
    # @items = []
    # @reviews.each do |review|
    #   @items << RakutenWebService::Ichiba::Item.search(itemCode: review.item.rakuten_item_id)
    # end
    @reviews = Review.all.page(params[:page]).per(6).reverse_order
  end

  def about
  end
end
