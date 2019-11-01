Rails.application.routes.draw do
  root to: "users#index"
  resource :users
end
