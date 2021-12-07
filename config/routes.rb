Rails.application.routes.draw do
  # ホーム
  root to: 'homes#top'
  get "/about", to: "homes#about"
  
  # ユーザー
  devise_for :users, skip: 'passwords'
  
  resources :users, skip:[:create] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw_customer'
  put 'users/:id/withdraw' => 'users#withdraw'
  
  # 投稿
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end