Rails.application.routes.draw do
  devise_for :users
  # , controllers: {
  #   sessions: 'users/sessions'
  # }
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create, :destroy]
      get 'likes', to: 'likes#like', on: :member
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
