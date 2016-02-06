Rails.application.routes.draw do
  # post "notifications/notify" => "notifications#notify"
  # post "twilio/voice" => "twilio#voice"
  root to: "pages#home"

  resources :characters, only: [:new, :show]
  resources :journey, only: [:show], param: :slug

  post "/new_game", to: 'journey#create'
  delete "/end_game", to: 'journey#destroy'
  post "/continue_game", to: 'journey#continue'

  resources :stores, only: [:show], param: :slug
  resources :trades, only: [:create]

  resources :categories, only: [:index, :show]
  resources :chips, only: [:index, :show], param: :slug
  resources :cart_chips, only: [:create, :index, :destroy, :update]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :orders, only: [:index, :create, :show, :new]
  
  namespace :admin do
    resources :chips, only: [:index, :show, :create, :new, :update, :edit, :destroy]
    resources :dashboard, only: [:index, :show]
    resources :orders, only: [:index, :update]
 end

  get '/about', to: 'pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'users#show'
  get '/cart', to: 'cart_chips#index'
  get '/:slug', to: 'categories#show'
  # get '/:slug', to: redirect('/categories/%{slug}'), as: "category_name"
end
