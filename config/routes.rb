Rails.application.routes.draw do
 
  devise_for :users
  root to: 'homes#top'
  
  resources :posts
  resources :users, only: [:show, :index, :edit, :update]
  resources :photos, only: [:new, :create, :show, :index]
  
  get '/about' => 'homes#about', as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
