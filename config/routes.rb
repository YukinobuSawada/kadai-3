Rails.application.routes.draw do

  root "home#top"
  
  get "home/about" =>"home#about"
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update, :index]
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
  resource :favorites, only: [:create, :destroy]
  resources :book_comments, only:[:create,:destroy]
 end

end
