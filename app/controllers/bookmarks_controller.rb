class BookmarksController < ApplicationController
	def create
		@items = RakutenWebService::Ichiba::Item.search(itemCode: params[:itemCode])
		result = ActiveRecord::Base.transaction do
			@item = Item.find_or_create_by(item_params)
			@bookmark = current_user.bookmarks.create(item_id: @item.id)
			true
		end
		if result
			redirect_to request.referrer || root_path
		else
			render 'reviews/new'
		end
	end

	def destroy
		@saved_item = Item.find(params[:id])
		@bookmark = current_user.bookmarks.find_by(item_id: @saved_item.id)
		@bookmark.destroy
		redirect_to request.referrer || root_path
	end

	private
	def item_params
    	{ name: @items.first['itemName'], rakuten_item_id: @items.first['itemCode'] }
  	end
end
