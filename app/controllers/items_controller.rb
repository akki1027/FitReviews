class ItemsController < ApplicationController
  def search
  	if params[:keyword]
  		@items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end

  def select_genre
  end

  def ranking
  end
end
