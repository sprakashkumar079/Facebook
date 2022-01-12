Rails.application.routes.draw do
  

  #device route for all like sign in sing up etc.
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #root route for first page of project
  #micropost route
  resources :microposts, only: [:create, :destroy]
  #for like
  resources :posts, only: [:index, :new, :create, :show, :destroy] do
      resources :likes, only: [:create]
  end
  #for comments
  resource :comments, only: [:new, :create, :destroy] do
    resources :likes, only: [:create]
  end
  #home route
  root 'static_pages#home'
end
