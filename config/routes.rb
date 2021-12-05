Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/new'
  get 'posts/edit'
  get 'posts/show'
  devise_for :users, skip: 'passwords'
  
  root to: 'homes#top'
  get "/about", to: "homes#about"
  
  resources :users, skip:[:create]
  get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw_customer'
  put 'users/:id/withdraw' => 'users#withdraw'  
end