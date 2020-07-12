class HomesController < ApplicationController
  def top
  end

  def fr_top
  	@rankings = Review.group(:item_id).limit(4).select("reviews_item_id, average_rate").order('average_rate desc').average(:rate)
    @reviews = Review.all.page(params[:page]).per(6).reverse_order
  end

  def about
  end
end
