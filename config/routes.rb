Rails.application.routes.draw do
	root "homes#fr_top"
 	get 'top' => 'homes#top', as: 'top'
  get 'about' => 'homes#about', as: 'about'

	devise_for :users, controllers: {
		sessions: 'users/sessions',
		passwords: 'users/passwords',
		registrations: 'users/registrations'
	}
  resources :users, only: [:edit, :show, :update]
	get 'users/:id/leave' => 'users#leave', as: 'users_leave'
	put 'users/:id/hide' => 'users#hide', as: 'users_hide'
	get 'users/:id/my_reviews' => 'users#my_reviews', as: 'users_my_reviews'
	get 'users/:id/my_bookmarks' => 'users#my_bookmarks', as: 'users_my_bookmarks'

	get 'reviews/search' => 'reviews#search', as: 'reviews_search'
	get 'reviews/save_item/:itemCode' => 'reviews#save_item', as: 'save_item'
	get 'reviews/new/:itemCode' => 'reviews#new', as: 'reviews_new'
	resources :reviews, except: [:index, :new, :show] do
		resource :likes, only: [:create, :destroy]
	end

	# wants to include item_id in url
	post 'bookmarks/:item_id' => 'bookmarks#create', as: 'bookmarks_create'
	resources :bookmarks, only: :destroy

	get 'items/search' => 'items#search', as: 'items_search'
  get 'items/ranking' => 'items#ranking', as: 'items_ranking'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
