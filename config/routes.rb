Rails.application.routes.draw do
  root 'accounts#index'
  get '/confirmation_pending' => 'public#after_registration_path'
  resources :search, only: [:index] do
    get 'show_posts', on: :member
  end
  devise_for :accounts, controllers: {
    confirmations: 'accounts/confirmations',
    registrations: 'accounts/registrations',
    sessions: 'accounts/sessions',
    passwords: 'accounts/passwords',
  }
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments
    member do
      put :archive
      put :unarchive
    end
    collection do
      get :archived
    end
  end
  resources :accounts, only: [:show, :index] do 
    member do
      put :activate
      put :deactivate
    end
  end  
  resources :likes, only: [:create, :destroy]
  post '/accounts/:id/follow', to: "accounts#follow", as: "follow_account"
  post '/accounts/:id/unfollow', to: "accounts#unfollow", as: "unfollow_account"
  get '/accounts/:id/admin_dashboard', to: "accounts#admin_dashboard", as: "admin_dashboard"
end
