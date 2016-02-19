Rails.application.routes.draw do
  require "sidekiq/web"

  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope '(:locale)', locale: /fr|en/ do
    get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale


    root to: 'pages#home'


    resources :companies, only: [:index] do
      resources :desks, only: [:index] do
        resources :bookings, only: [:new, :create] do
          get 'confirmation'
        end
        resources :user, only: [:update]
        resources :unavailability_ranges, only: [:create]
      end
    end

    resources :bookings, only: [] do
      resources :payments, only: [:new, :create]
    end

    namespace :account do
      resource :user, only: [:show, :edit, :update], controller: 'user'
      resource :credit_card, only: [:new, :create, :edit, :update], controller: 'credit_card'
      resources :companies, only: [:new, :create, :edit, :update] do
        resources :closing_days, only: [:index, :create, :destroy], controller: 'companies/closing_days'
        resources :desks, only: [:new, :create, :edit, :index, :update, :destroy] do
          resource :activation, only: [:create, :destroy], controller: 'desks/activation'
          resources :unavailability_ranges, only: [:index, :create, :destroy]
        end
      end
      resources :bookings, only: [:index, :show, :edit, :update] do
        resource :invoice, only: [:show], controller: 'invoice'
      end
    end
  end
end
