Rails.application.routes.draw do
  # ルートパス・アバウトページ
  root to: 'posts#timeline'
  get "about", to: "homes#about"
  
  # ユーザー
  devise_for :users, skip:[:passwords], controllers:{
    registrations: "user/registrations",
    sessions: "user/sessions"
  }
  
  resources :users, skip:[:create] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  
  # 投稿
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  
  # ハッシュタグ
  get '/post/hashtag/:name', to: "posts#hashtag"
end