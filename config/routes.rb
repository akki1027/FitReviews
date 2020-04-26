Rails.application.routes.draw do
	root "homes#top"
 	get 'fr_top' => 'homes#fr_top', as: 'fr_top'
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
	resources :reviews

	get 'items/search' => 'items#search', as: 'items_search'
  	get 'items/select_genre' => 'items#select_genre', as: 'select_genre'
  	get 'items/ranking' => 'items#ranking', as: 'items_ranking'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
