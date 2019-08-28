Rails.application.routes.draw do
  root 'static_pages#top' # ← 2.8 #
  get '/signup', to: 'users#new' # ← 3.5.2 2削除/ #
  resources :users # ← 5.2 #
  
end
