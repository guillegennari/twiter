Rails.application.routes.draw do
  get 'api/news', to: 'api#news', as: 'api_news'
  get 'api/tweets_between_dates/:date1/:date2', to: 'api#tweets_between_dates', as: 'tweets_between_dates'
  post 'api/tweets', to: 'api#create_tweet'

  #scope '/api' do
   # get '/news', to: 'api#news', as: 'api_news'
  #end

  ActiveAdmin.routes(self)
  
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
