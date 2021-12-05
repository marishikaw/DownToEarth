Rails.application.routes.draw do
  devise_for :users, skip: 'passwords'
  
  root to: 'homes#top'
  get "/about", to: "homes#about"
  
  resources :users, skip:[:create]
  get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw_customer'
  put 'users/:id/withdraw' => 'users#withdraw'
  
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end