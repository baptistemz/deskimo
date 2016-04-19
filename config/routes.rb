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
      resource :calendars, only: [:show] do
        get 'redirect', 'callback'
        post 'associate'
      end
      resource :user, only: [:show, :edit, :update], controller: 'user' do
        get 'archived_bookings'
      end
      resource :credit_card, only: [:new, :create, :edit, :update], controller: 'credit_card'
      resources :companies, only: [:new, :create, :edit, :update] do
        resource :welcome_message, only:[:new, :create, :edit, :update], controller: 'companies/welcome_message'
        resources :closing_days, only: [:index, :create, :destroy], controller: 'companies/closing_days'
        resources :desks, only: [:new, :create, :edit, :index, :update, :destroy] do
          resource :calendar, only: [:show], controller: 'desks/calendar'
          resource :activation, only: [:create, :destroy], controller: 'desks/activation'
          resources :unavailability_ranges, only: [:index, :create, :destroy]
        end
      end
      resources :desks, only: [] do
        get 'archived_bookings'
      end
      resources :bookings, only: [:index, :show, :edit, :update] do
        # get 'confirmation'
        resource :confirmation, only: [ :show, :create, :destroy], controller: 'bookings/confirmation'
        resource :invoice, only: [:show], controller: 'invoice'
      end
    end
  end
end
