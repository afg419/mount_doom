Rails.application.routes.draw do
  # post "notifications/notify" => "notifications#notify"
  # post "twilio/voice" => "twilio#voice"
  root to: "pages#home"

  resources :characters, only: [:new, :show]

  post "/new_game", to: 'journey#create'
  delete "/end_game", to: 'journey#destroy'
  post "/continue_game", to: 'journey#continue'
  get '/about', to: 'pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'users#show'

  resources :trades, only: [:create]
  resources :categories, only: [:index, :show]
  resources :items, only: [:index, :show], param: :slug
  resources :users, only: [:new, :create, :show, :edit, :update]

  namespace :admin do
    resources :items, only: [:index] #, :show, :create, :new, :update, :edit, :destroy]
    resources :dashboard, only: [:index]
    # resources :orders, only: [:index, :update]
  end

  resources :stores, only: [:show], path: ":location_slug", param: :slug
  resource :journey, only: [:show], path: ":slug", controller: 'journey' #needs to be last


 #  resources :orders, only: [:index, :create, :show, :new]
 #  resources :cart_items, only: [:create, :index, :destroy, :update]
 #
 #  get '/cart', to: 'cart_items#index'
 #  get '/:slug', to: 'categories#show'
 #  get '/:slug', to: redirect('/categories/%{slug}'), as: "category_name"
end
