Rr10Team71::Application.routes.draw do
  root :to => "home#index"

  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => 'authentications#failure'

  match '/twitter/tweets' => 'twitter#tweets', as: :tweets

  devise_for :users, :controllers => { :registrations => :registrations }

  resources :comments
  resource :profile, only: [:show, :edit, :update]

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
  end
end
