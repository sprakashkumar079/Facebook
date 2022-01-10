Rails.application.routes.draw do
  


  #device route for all like sign in sing up etc.
  devise_for :users
  #adding
  resources :microposts, only: %i[create destroy] do
      resources :likes, only: %i[create]
  end
  #ADDING COMMENT with like also
  resources :comments, only: %i[new create destroy] do
    resources :likes, only: %i[create]
  end

  #home route
  root 'static_pages#home'
end
