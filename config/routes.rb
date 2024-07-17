Rails.application.routes.draw do
  
   devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end

   get '/.env', to: 'your_controller#your_action'
   post '/', to: 'your_controller#your_action'
 
 scope module: :public do 
 
  devise_for :users
  root to: 'homes#top'
  
  resources :posts do
      resource :favorite, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :index, :edit, :update]
  resources :photos, only: [:new, :create, :show, :index]
  
  get '/about' => 'homes#about', as: "about"
  get "/search", to: "searches#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

end 