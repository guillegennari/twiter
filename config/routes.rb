Rails.application.routes.draw do
  #get 'users/follow'
  resources :tweets do
  post 'likes', to: 'tweets#likes'
  post 'retweet', to: 'tweets#retweet'
  end

  devise_for :users
  get 'home/index'
  get 'all_tweets', to: 'home#all_tweets', as: 'all_tweets'

  #get "users#follow"
  post 'follow/:user_id', to: 'users#follow', as: 'users_follow'

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
