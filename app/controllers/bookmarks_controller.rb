class BookmarksController < ApplicationController
	def create
		# @items = RakutenWebService::Ichiba::Item.search(itemCode: params[:itemCode])
		# result = ActiveRecord::Base.transaction do
		# 	@item = Item.find_by(item_params)
		# 	@bookmark = current_user.bookmarks.create(item_id: @item.id)
		# 	true
		# end
		# if result
		# 	redirect_to request.referrer || root_path
		# else
		# 	render 'reviews/new'
		# end

		# changed when to save items, so no longer need the codes above
		# also changed to AJAX
		@saved_item = Item.find(params[:item_id])
		bookmark = current_user.bookmarks.new(item_id: @saved_item.id)
		bookmark.save
	end

	def destroy
		# @saved_item = Item.find(params[:id])
		# @bookmark = current_user.bookmarks.find_by(item_id: @saved_item.id)
		# @bookmark.destroy
		# redirect_to request.referrer || root_path

		# changed when to save items, so no longer need the codes above
		# also switched to AJAX
		@saved_item = Item.find(params[:id])
		bookmark = current_user.bookmarks.find_by(item_id: @saved_item.id)
		bookmark.destroy
	end

	# no longer need the codes below
	# private
	# def item_params
 #    	{ name: @items.first['itemName'], rakuten_item_id: @items.first['itemCode'] }
 #  	end
end
