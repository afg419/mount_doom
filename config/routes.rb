Rails.application.routes.draw do
  # post "notifications/notify" => "notifications#notify"
  # post "twilio/voice" => "twilio#voice"
  root to: "pages#home"
  resources :characters, only: [:new, :show, :update, :create]

  post "/new_game", to: 'journey#create'
  delete "/end_game", to: 'journey#destroy'
  post "/continue_game", to: 'journey#continue'
  get '/about', to: 'pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'users#show'
  get '/travel_summary', to: 'journey#summary'
  get '/travel_game', to: 'journey#game'
  get '/restart_game', to: 'journey#restart', as: 'restart_game'
  get '/help', to: 'journey#help'
  get 'admin/activate_avatar', to: 'admin/avatars#activate'

  resources :trades, only: [:create]
  resources :categories, only: [:index, :show]
  resources :items, only: [:index, :show], param: :slug
  resources :users, only: [:new, :create, :show, :edit, :update]

  namespace :admin do
    resources :items, only: [:index, :create, :new, :update, :edit, :destroy]
    resources :avatars, only: [:index, :create, :new, :update, :edit, :destroy]
    resources :stores, only: [:index, :update, :edit]
    resources :dashboard, only: [:index]
    # resources :orders, only: [:index, :update]
  end

  get '/:slug/map', to: 'journey#map'
  # get '/map', to: 'journey#map'
  resources :stores, only: [:show], path: ":location_slug", param: :slug
  resource :journey, only: [:show], path: ":slug", controller: 'journey' #needs to be last


 #  resources :orders, only: [:index, :create, :show, :new]
 #  resources :cart_items, only: [:create, :index, :destroy, :update]
 #
 #  get '/cart', to: 'cart_items#index'
 #  get '/:slug', to: 'categories#show'
 #  get '/:slug', to: redirect('/categories/%{slug}'), as: "category_name"
end
