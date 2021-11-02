Rails.application.routes.draw do
  root to: "homes#top"
  get "/home/about" => "homes#about"
  devise_for :users 
  
  resources :users, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
  end
      
      
  resources :books, only: [ :create, :index, :show, :edit, :update, :destroy] do
   resource :favorites, only: [:create, :destroy]
   resource :book_comments, only: [:create, :destroy]
   
  end
  
  resources :users, only: [ :index, :show, :edit, :update]
  
end
