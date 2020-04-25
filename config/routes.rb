Rails.application.routes.draw do
	root "homes#top"
 	get 'fr_top' => 'homes#fr_top', as: 'fr_top'
  	get 'about' => 'homes#about', as: 'about'
  	devise_for :users
  	resources :users, only: [:edit, :show, :update]
	get 'users/:id/leave' => 'users#leave', as: 'users_leave'
	put 'users/:id/hide' => 'users#hide', as: 'users_hide'
	get 'users/:id/my_reviews' => 'users#my_reviews', as: 'users_my_reviews'
	get 'users/:id/my_bookmarks' => 'users#my_bookmarks', as: 'users_my_bookmarks'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
