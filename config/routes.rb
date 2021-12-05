Rails.application.routes.draw do
  get 'user/index'
  get 'user/edit'
  get 'user/show'
  get 'user/unsubscribe'
  get 'index/edit'
  get 'index/show'
  get 'index/update'
  get 'index/unsubscribe'
  get 'index/withdraw'
  devise_for :users, skip: 'passwords'
  
  root to: 'homes#top'
  get "/about", to: "homes#about"
  
end