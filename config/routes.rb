Rails.application.routes.draw do
  # ホーム
  root to: 'homes#top'
  get "/about", to: "homes#about"
  
  # ユーザー
  devise_for :users, skip: 'passwords'
  resources :users, skip:[:create]
  get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw_customer'
  put 'users/:id/withdraw' => 'users#withdraw'
  
  # 投稿（いいね、コメント）
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end