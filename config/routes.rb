Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create, :destroy]
      get 'likes', to: 'likes#like', on: :member
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts do 
          resources :comments, format: :json 
        end
      end
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
