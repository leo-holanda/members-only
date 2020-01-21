Rails.application.routes.draw do
  resources :users do
    resources :post, only: [:new, :create, :index]
  end
  
  root to: "users#index"
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

end
