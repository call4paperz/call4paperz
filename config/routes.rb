Call4Paperz::Application.routes.draw do
  root :to => "home#index"

  get '/auth/:provider/callback' => 'authentications#create'
  get '/auth/failure' => 'authentications#failure'

  devise_for :users, controllers: { registrations: :registrations }

  resources :comments, only: :create
  resource :profile, only: [:show, :edit, :update] do
    get :resend_confirmation_email
  end

  resources :events do
    member do
      get :crop
    end

    resource :close, only: [:edit, :update], controller: "event_close"

    resources :proposals do
      member do
        get :like
        get :dislike
      end
    end

    get '/tags/:tag', to: 'events#tags', on: :collection, as: :tags
  end

  get :about, to: 'home#about'

  get '/twitter/last' => 'twitter#last', as: :last_tweet

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
