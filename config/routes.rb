Rails.application.routes.draw do
  root to: "users#new"
  get 'users/new'
end
