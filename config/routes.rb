Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'sessions', registrations: "registrations" }
  root to: 'pages#home'

  resources :companies, only: [:index] do
    resources :desks, only: [:index] do
      resources :bookings, only: [:new, :create]
      resources :unavailability_ranges, only: [:create]
    end
  end



  namespace :account do
    resource :user, only: [:show], controller: 'user'
    resources :companies, only: [:new, :create, :edit, :update] do
      resources :desks, only: [:new, :create, :edit, :index, :update, :destroy] do
        resource :activation, only: [:create, :destroy], controller: 'desks/activation'
        resources :unavailability_ranges, only: [:new, :create, :destroy]
      end
    end
    resources :bookings, only: [:index, :show, :edit, :update]
  end
end
