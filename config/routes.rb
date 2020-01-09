Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :sign_up, only: [:create]
  resource :sign_in, only: [:create]
  resources :users, only: [:index]
end
