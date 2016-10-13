Rails.application.routes.draw do
  resources :users, param: :username
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
