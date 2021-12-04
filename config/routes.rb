Rails.application.routes.draw do
  devise_for :users, skip: 'passwords'
  
  root to: 'homes#top'
  get "/about", to: "homes#about"
  
end