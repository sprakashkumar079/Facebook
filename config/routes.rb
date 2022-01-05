Rails.application.routes.draw do
  
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #root route for first page of project
  root 'static_pages#home'
end
