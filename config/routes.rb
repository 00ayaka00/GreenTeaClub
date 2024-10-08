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
   
   resources :notifications, only: :index

 scope module: :public do

  devise_for :users
  root to: 'homes#top'
  

  resources :posts do
       collection do
        get 'ranking'  
       end
       resources :users, only: [:show]
       resource :favorite, only: [:create, :destroy]
       resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :index, :edit, :update] do
    member do
       get :favorites 
    end
    resource :relationships, only: [:create, :destroy]
   	get "followings" => "relationships#followings", as: "followings"
   	get "followers" => "relationships#followers", as: "followers"
  end


  get '/about' => 'homes#about', as: "about"
  get "/search", to: "searches#search"
  get '/app/assets/images/:filename', to: redirect('/assets/%{filename}')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

end