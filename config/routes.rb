Rails.application.routes.draw do

  root "home#top"
  
  get "home/about" =>"home#about"
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update, :index] do
  	member do
  		get :following, :followers
  	end
  end
  resources :relationships, only:[:create,:destroy]
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
  resource :favorites, only: [:create, :destroy]
  resources :book_comments, only:[:create,:destroy]
 end
 get '/search' => 'search#search'
end
