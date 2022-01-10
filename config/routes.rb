Rails.application.routes.draw do
  
  get 'likes/create'
  get 'comments/new'
  get 'comments/create'
  #device route for all like sign in sing up etc.
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #root route for first page of project
  #micropost route
  resources :microposts, only: [:create, :destroy]
  #home route
  root 'static_pages#home'
end
