Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  #ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do # ← 5.2 / 追加 9.3.1 
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
    end
  end
end

# 追加 6.1 2~3,6~8